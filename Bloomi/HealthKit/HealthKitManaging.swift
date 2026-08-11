//
//  HealthKitManaging.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import Foundation

protocol HealthKitManaging {
    var isHealthDataAvailable: Bool { get }

    /// Requests read/write access for the quantity types Bloomi uses.
    func requestAuthorization() async throws

    /// Writes whichever fields of the measurement have a HealthKit
    /// equivalent (weight, body fat %, muscle mass, waist). Fields
    /// with no HealthKit quantity type are ignored here.
    func save(_ measurement: BodyMeasurement) async throws

    /// Convenience used to pre-fill a new entry with the most recent
    /// weight already logged in Health, if any.
    func fetchLatestWeightKg() async throws -> Double?
}
