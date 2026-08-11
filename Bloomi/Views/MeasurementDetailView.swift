//
//  MeasurementDetailView.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import SwiftUI

struct MeasurementDetailView: View {
    let measurement: BodyMeasurement

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    private var rows: [(String, String)] {
        var rows: [(String, String)] = []
        if let v = measurement.weightKg { rows.append(("Weight", "\(v.formatted(.number.precision(.fractionLength(1)))) kg")) }
        if let v = measurement.bodyFatPercentage { rows.append(("Body Fat", "\(v.formatted(.number.precision(.fractionLength(1))))%")) }
        if let v = measurement.muscleMassKg { rows.append(("Muscle Mass", "\(v.formatted(.number.precision(.fractionLength(1)))) kg")) }
        if let v = measurement.chestCm { rows.append(("Chest", "\(v.formatted(.number.precision(.fractionLength(1)))) cm")) }
        if let v = measurement.waistCm { rows.append(("Waist", "\(v.formatted(.number.precision(.fractionLength(1)))) cm")) }
        if let v = measurement.hipCm { rows.append(("Hip", "\(v.formatted(.number.precision(.fractionLength(1)))) cm")) }
        if let v = measurement.armCm { rows.append(("Arm", "\(v.formatted(.number.precision(.fractionLength(1)))) cm")) }
        if let v = measurement.legCm { rows.append(("Leg", "\(v.formatted(.number.precision(.fractionLength(1)))) cm")) }
        return rows
    }

    var body: some View {
        List {
            Section {
                Text(Self.dateFormatter.string(from: measurement.date))
                    .font(.headline)
            }
            Section("Measurements") {
                ForEach(rows, id: \.0) { row in
                    HStack {
                        Text(row.0)
                        Spacer()
                        Text(row.1)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MeasurementDetailView(measurement: BodyMeasurement(weightKg: 68.4, bodyFatPercentage: 24.5, muscleMassKg: 45.2, waistCm: 74, chestCm: 90, hipCm: 96, armCm: 27, legCm: 55))
    }
}
