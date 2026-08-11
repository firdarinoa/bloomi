//
//  AddMeasurementViewModel.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import Foundation

@MainActor
final class AddMeasurementViewModel: ObservableObject {

    @Published var weightText = ""
    @Published var bodyFatText = ""
    @Published var muscleMassText = ""
    @Published var chestText = ""
    @Published var waistText = ""
    @Published var hipText = ""
    @Published var armText = ""
    @Published var legText = ""

    @Published private(set) var isSaving = false
    @Published var errorMessage: String?

    private let store: MeasurementStoring
    private let healthKit: HealthKitManaging

    init(store: MeasurementStoring, healthKit: HealthKitManaging) {
        self.store = store
        self.healthKit = healthKit
    }

    var canSave: Bool {
        !weightText.isEmpty || !bodyFatText.isEmpty || !muscleMassText.isEmpty
            || !chestText.isEmpty || !waistText.isEmpty || !hipText.isEmpty
            || !armText.isEmpty || !legText.isEmpty
    }

    /// Returns true on success so the view can dismiss.
    func save() async -> Bool {
        guard canSave else {
            errorMessage = "Enter at least one measurement."
            return false
        }

        isSaving = true
        defer { isSaving = false }

        let measurement = BodyMeasurement(
            weightKg: Double(weightText),
            bodyFatPercentage: Double(bodyFatText),
            muscleMassKg: Double(muscleMassText),
            waistCm: Double(waistText),
            chestCm: Double(chestText),
            hipCm: Double(hipText),
            armCm: Double(armText),
            legCm: Double(legText)
        )

        do {
            try await store.add(measurement)
            // Best-effort sync — a HealthKit failure shouldn't lose the
            // entry the user already saved locally.
            try? await healthKit.save(measurement)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
