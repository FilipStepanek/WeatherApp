//
//  LoadingView.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 13.02.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle (tint: .mainText))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#if DEBUG
#Preview {
    LoadingView()
}
#endif
