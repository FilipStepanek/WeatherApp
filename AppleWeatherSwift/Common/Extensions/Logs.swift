//
//  LogData.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 16.03.2024.
//

import OSLog

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs for networking information.
    static let networking = Logger(subsystem: subsystem, category: "network")
    
    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
    
    /// Logs the view cycles like a view that appeared.
    static let dataFlow = Logger(subsystem: subsystem, category: "dataFlow")

    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
}
