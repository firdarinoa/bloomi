//
//  AddMeasurementView.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import SwiftUI

struct AddMeasurementView: View {
    @ObservedObject var viewModel: AddMeasurementViewModel
    @Environment(\.dismiss) private var dismiss
    let onSaved: () -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Body Composition") {
                    numberField("Weight (kg)", text: $viewModel.weightText)
                    numberField("Body Fat (%)", text: $viewModel.bodyFatText)
                    numberField("Muscle Mass (kg)", text: $viewModel.muscleMassText)
                }

                Section("Circumferences (cm)") {
                    numberField("Chest", text: $viewModel.chestText)
                    numberField("Waist", text: $viewModel.waistText)
                    numberField("Hip", text: $viewModel.hipText)
                    numberField("Arm", text: $viewModel.armText)
                    numberField("Leg", text: $viewModel.legText)
                }

                if let errorMessage = viewModel.errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle("New Measurement")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    if viewModel.isSaving {
                        ProgressView()
                    } else {
                        Button("Save") {
                            Task {
                                if await viewModel.save() {
                                    onSaved()
                                    dismiss()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func numberField(_ title: String, text: Binding<String>) -> some View {
        HStack {
            Text(title)
            Spacer()
            TextField("", text: text)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    AddMeasurementView(
        viewModel: AddMeasurementViewModel(store: MeasurementStore(), healthKit: HealthKitManager()),
        onSaved: {}
    )
}
