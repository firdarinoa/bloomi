//
//  MeasurementRowView.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import SwiftUI

struct MeasurementRowView: View {
    let measurement: BodyMeasurement

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(Self.dateFormatter.string(from: measurement.date))
                .font(.headline)

            HStack(spacing: 12) {
                if let weight = measurement.weightKg {
                    Label("\(weight, specifier: "%.1f") kg", systemImage: "scalemass")
                }
                if let bodyFat = measurement.bodyFatPercentage {
                    Label("\(bodyFat, specifier: "%.1f")%", systemImage: "percent")
                }
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    MeasurementRowView(measurement: BodyMeasurement(weightKg: 68.4, bodyFatPercentage: 24.5))
}
