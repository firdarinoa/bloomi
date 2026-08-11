//
//  BloomiApp.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import SwiftUI

@main
struct BloomiApp: App {
    var body: some Scene {
        WindowGroup {
            MeasurementListView(viewModel: MeasurementLogViewModel())
        }
    }
}
