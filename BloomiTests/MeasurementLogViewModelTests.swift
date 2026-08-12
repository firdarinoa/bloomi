//
//  MeasurementLogViewModelTests.swift
//  BloomiTests
//
//  Created by Firda Sahidi on 11/08/2026.
//

import XCTest
@testable import Bloomi

@MainActor
final class MeasurementLogViewModelTests: XCTestCase {

    func testLoadPopulatesMeasurementsFromStore() async {
        let store = FakeMeasurementStore()
        store.measurements = [
            BodyMeasurement(date: Date(timeIntervalSince1970: 1000), weightKg: 70),
            BodyMeasurement(date: Date(timeIntervalSince1970: 2000), weightKg: 69)
        ]
        let sut = MeasurementLogViewModel(store: store, healthKit: FakeHealthKitManager())

        await sut.load()

        XCTAssertEqual(sut.measurements.count, 2)
        XCTAssertEqual(sut.measurements.first?.weightKg, 69)
    }

    func testLoadSurfacesStoreErrorMessage() async {
        struct SampleError: LocalizedError {
            var errorDescription: String? { "failed to load" }
        }
        let store = FakeMeasurementStore()
        store.loadAllError = SampleError()
        let sut = MeasurementLogViewModel(store: store, healthKit: FakeHealthKitManager())

        await sut.load()

        XCTAssertEqual(sut.errorMessage, "failed to load")
        XCTAssertTrue(sut.measurements.isEmpty)
    }

    func testDeleteRemovesMeasurementFromStoreAndList() async {
        let measurement = BodyMeasurement(weightKg: 70)
        let store = FakeMeasurementStore()
        store.measurements = [measurement]
        let sut = MeasurementLogViewModel(store: store, healthKit: FakeHealthKitManager())
        await sut.load()

        await sut.delete(measurement)

        XCTAssertTrue(sut.measurements.isEmpty)
        XCTAssertTrue(store.measurements.isEmpty)
    }

    func testOnAppearMarksHealthAuthorizedWhenGranted() async {
        let healthKit = FakeHealthKitManager()
        let sut = MeasurementLogViewModel(store: FakeMeasurementStore(), healthKit: healthKit)

        await sut.onAppear()

        XCTAssertTrue(healthKit.didRequestAuthorization)
        XCTAssertTrue(sut.isHealthAuthorized)
    }

    func testOnAppearLeavesHealthUnauthorizedWhenDenied() async {
        struct DeniedError: Error {}
        let healthKit = FakeHealthKitManager()
        healthKit.requestAuthorizationError = DeniedError()
        let sut = MeasurementLogViewModel(store: FakeMeasurementStore(), healthKit: healthKit)

        await sut.onAppear()

        XCTAssertFalse(sut.isHealthAuthorized)
    }
}
