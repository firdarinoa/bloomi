//
//  HealthKitError.swift
//
//
//  Created by Firda Sahidi on 11/08/2026.
//

import Foundation

enum HealthKitError: Error, LocalizedError {
    case notAvailable
    case authorizationDenied
    case saveFailed(Error)
    case readFailed(Error)

    var errorDescription: String? {
        switch self {
        case .notAvailable:
            return "Health data isn't available on this device."
        case .authorizationDenied:
            return "Bloomi doesn't have permission to access Health data."
        case .saveFailed(let error):
            return "Couldn't save to Health: \(error.localizedDescription)"
        case .readFailed(let error):
            return "Couldn't read from Health: \(error.localizedDescription)"
        }
    }
}
