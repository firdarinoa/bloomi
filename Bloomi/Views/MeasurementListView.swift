//
//  MeasurementListView.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import SwiftUI

struct MeasurementListView: View {
    @ObservedObject var viewModel: MeasurementLogViewModel
    @State private var isShowingAddSheet = false

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Bloomi")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            isShowingAddSheet = true
                        } label: {
                            Label("Add Measurement", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isShowingAddSheet) {
                    AddMeasurementView(
                        viewModel: AddMeasurementViewModel(store: viewModel.store, healthKit: viewModel.healthKit)
                    ) {
                        Task { await viewModel.load() }
                    }
                }
                .task {
                    await viewModel.onAppear()
                }
                .refreshable {
                    await viewModel.load()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.measurements.isEmpty {
            ProgressView("Loading…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if viewModel.measurements.isEmpty {
            ContentUnavailableView(
                "No measurements yet",
                systemImage: "ruler",
                description: Text("Tap + to log your first weigh-in.")
            )
        } else {
            List {
                if !viewModel.isHealthAuthorized {
                    Section {
                        Label("Health access not granted — entries are saved locally only.", systemImage: "heart.slash")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                ForEach(viewModel.measurements) { measurement in
                    NavigationLink(value: measurement) {
                        MeasurementRowView(measurement: measurement)
                    }
                }
                .onDelete { offsets in
                    Task {
                        for index in offsets {
                            await viewModel.delete(viewModel.measurements[index])
                        }
                    }
                }
            }
            .navigationDestination(for: BodyMeasurement.self) { measurement in
                MeasurementDetailView(measurement: measurement)
            }
        }
    }
}

#Preview {
    MeasurementListView(viewModel: MeasurementLogViewModel())
}
