//
//  HealthKitManager.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import Foundation
import HealthKit

final class HealthKitManager: HealthKitManaging {
    private let store = HKHealthStore()

    private let weightType = HKQuantityType(.bodyMass)
    private let bodyFatType = HKQuantityType(.bodyFatPercentage)
    private let leanBodyMassType = HKQuantityType(.leanBodyMass)
    private let waistType = HKQuantityType(.waistCircumference)

    var isHealthDataAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }

    private var readWriteTypes: Set<HKSampleType> {
        [weightType, bodyFatType, leanBodyMassType, waistType]
    }

    func requestAuthorization() async throws {
        guard isHealthDataAvailable else {
            throw HealthKitError.notAvailable
        }
        do {
            try await store.requestAuthorization(toShare: readWriteTypes, read: readWriteTypes)
        } catch {
            throw HealthKitError.authorizationDenied
        }
    }

    func save(_ measurement: BodyMeasurement) async throws {
        guard isHealthDataAvailable else {
            throw HealthKitError.notAvailable
        }

        var samples: [HKQuantitySample] = []
        let date = measurement.date

        if let weightKg = measurement.weightKg {
            let quantity = HKQuantity(unit: .gramUnit(with: .kilo), doubleValue: weightKg)
            samples.append(HKQuantitySample(type: weightType, quantity: quantity, start: date, end: date))
        }

        if let bodyFatPercentage = measurement.bodyFatPercentage {
            let quantity = HKQuantity(unit: .percent(), doubleValue: bodyFatPercentage / 100.0)
            samples.append(HKQuantitySample(type: bodyFatType, quantity: quantity, start: date, end: date))
        }

        if let muscleMassKg = measurement.muscleMassKg {
            let quantity = HKQuantity(unit: .gramUnit(with: .kilo), doubleValue: muscleMassKg)
            samples.append(HKQuantitySample(type: leanBodyMassType, quantity: quantity, start: date, end: date))
        }

        if let waistCm = measurement.waistCm {
            let quantity = HKQuantity(unit: .meterUnit(with: .centi), doubleValue: waistCm)
            samples.append(HKQuantitySample(type: waistType, quantity: quantity, start: date, end: date))
        }

        guard !samples.isEmpty else { return }

        do {
            try await store.save(samples)
        } catch {
            throw HealthKitError.saveFailed(error)
        }
    }

    func fetchLatestWeightKg() async throws -> Double? {
        guard isHealthDataAvailable else {
            throw HealthKitError.notAvailable
        }

        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.quantitySample(type: weightType)],
            sortDescriptors: [sortDescriptor],
            limit: 1
        )

        do {
            let results = try await descriptor.result(for: store)
            return results.first?.quantity.doubleValue(for: .gramUnit(with: .kilo))
        } catch {
            throw HealthKitError.readFailed(error)
        }
    }
}
