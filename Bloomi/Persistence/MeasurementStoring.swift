//
//  MeasurementStoring.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//
import Foundation

protocol MeasurementStoring {
    func loadAll() async throws -> [BodyMeasurement]
    func add(_ measurement: BodyMeasurement) async throws
    func delete(id: UUID) async throws
}
