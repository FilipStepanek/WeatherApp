//
//  ExtensionView.swift
//  WeatherAppWidgetsExtension
//
//  Created by Filip Štěpánek on 01.04.2024.
//

import SwiftUI
import WidgetKit

extension View {
    func widgetBackground<Background: View>(backgroundView: Background) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return self.containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return self.background(backgroundView)
        }
    }
}
