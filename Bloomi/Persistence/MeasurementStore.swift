//
//  MeasurementStore.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import Foundation

actor MeasurementStore: MeasurementStoring {
    private let fileURL: URL

    init(fileName: String = "measurements.json") {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.fileURL = documents.appendingPathComponent(fileName)
    }

    func loadAll() async throws -> [BodyMeasurement] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([BodyMeasurement].self, from: data)
            .sorted { $0.date > $1.date }
    }

    func add(_ measurement: BodyMeasurement) async throws {
        var all = try await loadAll()
        all.append(measurement)
        try await write(all)
    }

    func delete(id: UUID) async throws {
        var all = try await loadAll()
        all.removeAll { $0.id == id }
        try await write(all)
    }

    private func write(_ measurements: [BodyMeasurement]) async throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(measurements)
        try data.write(to: fileURL, options: .atomic)
    }
}
