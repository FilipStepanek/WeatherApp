//
//  ContentView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Image(.tabBarToday)
                    Text("today.Tabbar.Title")
                        .font(.tabBarFont)
                        .background()
                }
                .tag(0)
                .toolbarBackground(.mainBackground, for: .tabBar)
            
            ForecastView()
                .tabItem {
                    Image(.tabBarForecast)
                    Text("forecast.TabBar.Title")
                        .font(.tabBarFont)
                        .background(.tabBar)
                }
                .tag(1)
                .toolbarBackground(.mainBackground, for: .tabBar)
        }
        .accentColor(.tabBar)
    }
}

#Preview {
    ContentView()
}
