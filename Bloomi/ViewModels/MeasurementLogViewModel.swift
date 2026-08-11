//
//  MeasurementLogViewModel.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import Foundation

@MainActor
final class MeasurementLogViewModel: ObservableObject {

    @Published private(set) var measurements: [BodyMeasurement] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    @Published private(set) var isHealthAuthorized = false

    let store: MeasurementStoring
    let healthKit: HealthKitManaging

    init(store: MeasurementStoring = MeasurementStore(), healthKit: HealthKitManaging = HealthKitManager()) {
        self.store = store
        self.healthKit = healthKit
    }

    func onAppear() async {
        await requestHealthAccess()
        await load()
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            measurements = try await store.loadAll()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func delete(_ measurement: BodyMeasurement) async {
        do {
            try await store.delete(id: measurement.id)
            measurements.removeAll { $0.id == measurement.id }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func requestHealthAccess() async {
        guard healthKit.isHealthDataAvailable else { return }
        do {
            try await healthKit.requestAuthorization()
            isHealthAuthorized = true
        } catch {
            // Health access is a nice-to-have, not a hard requirement —
            // the app still works fully on local storage if it's denied.
            isHealthAuthorized = false
        }
    }
}
