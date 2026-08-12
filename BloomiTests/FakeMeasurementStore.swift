//
//  FakeMeasurementStore.swift
//  BloomiTests
//
//  Created by Firda Sahidi on 11/08/2026.
//

import Foundation
@testable import Bloomi

final class FakeMeasurementStore: MeasurementStoring {
    var measurements: [BodyMeasurement] = []
    var loadAllError: Error?
    var addError: Error?
    var deleteError: Error?

    func loadAll() async throws -> [BodyMeasurement] {
        if let loadAllError { throw loadAllError }
        return measurements.sorted { $0.date > $1.date }
    }

    func add(_ measurement: BodyMeasurement) async throws {
        if let addError { throw addError }
        measurements.append(measurement)
    }

    func delete(id: UUID) async throws {
        if let deleteError { throw deleteError }
        measurements.removeAll { $0.id == id }
    }
}
