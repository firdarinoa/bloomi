//
//  BodyMeasurement.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import Foundation

struct BodyMeasurement: Identifiable, Codable, Hashable {
    let id: UUID
    let date: Date

    // Syncs with HealthKit
    var weightKg: Double?
    var bodyFatPercentage: Double?   // stored as 0–100
    var muscleMassKg: Double?        // maps to HealthKit's leanBodyMass
    var waistCm: Double?

    // Local-only (no HealthKit quantity type exists for these)
    var chestCm: Double?
    var hipCm: Double?
    var armCm: Double?
    var legCm: Double?

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        weightKg: Double? = nil,
        bodyFatPercentage: Double? = nil,
        muscleMassKg: Double? = nil,
        waistCm: Double? = nil,
        chestCm: Double? = nil,
        hipCm: Double? = nil,
        armCm: Double? = nil,
        legCm: Double? = nil
    ) {
        self.id = id
        self.date = date
        self.weightKg = weightKg
        self.bodyFatPercentage = bodyFatPercentage
        self.muscleMassKg = muscleMassKg
        self.waistCm = waistCm
        self.chestCm = chestCm
        self.hipCm = hipCm
        self.armCm = armCm
        self.legCm = legCm
    }
}
