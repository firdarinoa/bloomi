//
//  AddMeasurementViewModelTests.swift
//  BloomiTests
//
//  Created by Firda Sahidi on 11/08/2026.
//

import XCTest
@testable import Bloomi

@MainActor
final class AddMeasurementViewModelTests: XCTestCase {

    func testCanSaveIsFalseWhenAllFieldsEmpty() {
        let sut = AddMeasurementViewModel(store: FakeMeasurementStore(), healthKit: FakeHealthKitManager())

        XCTAssertFalse(sut.canSave)
    }

    func testCanSaveIsTrueWhenAtLeastOneFieldIsFilled() {
        let sut = AddMeasurementViewModel(store: FakeMeasurementStore(), healthKit: FakeHealthKitManager())

        sut.weightText = "70"

        XCTAssertTrue(sut.canSave)
    }

    func testSaveFailsValidationWhenNoFieldsAreFilled() async {
        let sut = AddMeasurementViewModel(store: FakeMeasurementStore(), healthKit: FakeHealthKitManager())

        let result = await sut.save()

        XCTAssertFalse(result)
        XCTAssertNotNil(sut.errorMessage)
    }

    func testSaveWritesToStoreAndHealthKit() async {
        let store = FakeMeasurementStore()
        let healthKit = FakeHealthKitManager()
        let sut = AddMeasurementViewModel(store: store, healthKit: healthKit)
        sut.weightText = "70.5"
        sut.bodyFatText = "22"
        sut.chestText = "90"

        let result = await sut.save()

        XCTAssertTrue(result)
        XCTAssertEqual(store.measurements.count, 1)
        XCTAssertEqual(store.measurements.first?.weightKg, 70.5)
        XCTAssertEqual(store.measurements.first?.chestCm, 90)
        XCTAssertEqual(healthKit.savedMeasurements.count, 1)
    }

    func testSaveSucceedsEvenWhenHealthKitSaveFails() async {
        struct SampleError: Error {}
        let store = FakeMeasurementStore()
        let healthKit = FakeHealthKitManager()
        healthKit.saveError = SampleError()
        let sut = AddMeasurementViewModel(store: store, healthKit: healthKit)
        sut.weightText = "70"

        let result = await sut.save()

        XCTAssertTrue(result)
        XCTAssertEqual(store.measurements.count, 1)
    }

    func testSaveFailsWhenStoreThrows() async {
        struct SampleError: LocalizedError {
            var errorDescription: String? { "disk full" }
        }
        let store = FakeMeasurementStore()
        store.addError = SampleError()
        let sut = AddMeasurementViewModel(store: store, healthKit: FakeHealthKitManager())
        sut.weightText = "70"

        let result = await sut.save()

        XCTAssertFalse(result)
        XCTAssertEqual(sut.errorMessage, "disk full")
    }
}
