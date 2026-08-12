//
//  FakeHealthKitManager.swift
//  BloomiTests
//
//  Created by Firda Sahidi on 11/08/2026.
//

import Foundation
@testable import Bloomi

final class FakeHealthKitManager: HealthKitManaging {
    var isHealthDataAvailable = true
    var requestAuthorizationError: Error?
    var saveError: Error?
    var latestWeightKg: Double?

    private(set) var didRequestAuthorization = false
    private(set) var savedMeasurements: [BodyMeasurement] = []

    func requestAuthorization() async throws {
        didRequestAuthorization = true
        if let requestAuthorizationError { throw requestAuthorizationError }
    }

    func save(_ measurement: BodyMeasurement) async throws {
        if let saveError { throw saveError }
        savedMeasurements.append(measurement)
    }

    func fetchLatestWeightKg() async throws -> Double? {
        latestWeightKg
    }
}
