//
//  ExtensionImage.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 13.03.2024.
//

import Foundation
import SwiftUI

// MARK: - Extension for TodayDetailInfo view
extension Image {
    func imageFrameShape() -> some View {
        self
            .frame(width: 40, height: 40)
            .background(.todayImageSpahe)
            .cornerRadius(40)
    }

// MARK: - Extension for ForecastDetailView
    func imageSize() -> some View {
        self
            .resizable()
            .frame(maxWidth: 28.8, maxHeight: 28.8)
            .aspectRatio(contentMode: .fit)
    }
}
