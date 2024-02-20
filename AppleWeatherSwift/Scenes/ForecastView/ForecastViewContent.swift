//
//  ForecastViewContent.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 08.01.2024.
//

//import SwiftUI
//
//struct ForecastViewContent: View {
//    var weather: ForecastResponse
//    var weatherNow: CurrentResponse
//    let headerText = String(localized: "forecast.header.title")
//    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
//    
//    var groupedData: [String: [ForecastResponse.ListResponse]] {
//        var groupedData: [String: [ForecastResponse.ListResponse]] = [:]
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        
//        for forecast in weather.list {
//            let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(forecast.date)))
//            
//            if var existingData = groupedData[dateString] {
//                existingData.append(forecast)
//                groupedData[dateString] = existingData
//            } else {
//                groupedData[dateString] = [forecast]
//            }
//        }
//        
//        return groupedData
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(headerText)
//                .font(.headlineTwo)
//                .foregroundStyle(.mainText)
//            
//            NavigationView {
//                ScrollView(.vertical, showsIndicators: false) {
//                    ForEach(Array(groupedData.keys.sorted().enumerated()), id: \.1) { dayIndex, dateString in
//                        let forecasts = groupedData[dateString]!
//                        
//                        LazyVGrid(columns: columns, spacing: 8, pinnedViews: [.sectionHeaders]) {
//                            Section(header: ForecastHeaderInfoView(dayIndex: dayIndex)
//                            ) {
//                                if dayIndex == 0 {
//                                    ForecastDetailNowView(weatherNow: weatherNow)
//                                }
//                                ForEach(forecasts, id: \.date) { forecast in
//                                    ForecastDetailView(weather: forecast)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .padding(.top, 30)
//        .padding()
//        .ignoresSafeArea(.all, edges: .bottom)
//    }
//}
//
//struct ForecastViewContent_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastViewContent(weather: previewForecast, weatherNow: previewWeather)
//    }
//}

//MARK: - Test refresh page by scrolling

import SwiftUI

// A preference key to store ScrollView offset
struct ViewOffsetKeyForecast: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ForecastViewContent: View {
    
    @Environment(\.refresh) private var refresh
    @State private var isCurrentlyRefreshing = false
    let amountToPullBeforeRefreshing: CGFloat = 180
    func refreshData() async {
        // do work to asyncronously refresh your data here
        try? await Task.sleep(nanoseconds: 3_000_000_000)
    }
    
    var weather: ForecastResponse
    var weatherNow: CurrentResponse
    let headerText = String(localized: "forecast.header.title")
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    var groupedData: [String: [ForecastResponse.ListResponse]] {
        var groupedData: [String: [ForecastResponse.ListResponse]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for forecast in weather.list {
            let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(forecast.date)))
            
            if var existingData = groupedData[dateString] {
                existingData.append(forecast)
                groupedData[dateString] = existingData
            } else {
                groupedData[dateString] = [forecast]
            }
        }
        
        return groupedData
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(headerText)
                .font(.headlineTwo)
                .foregroundStyle(.mainText)
            
            NavigationView {
                ScrollView(.vertical, showsIndicators: false){
                if isCurrentlyRefreshing {
                    ProgressView()
                }
                    ForEach(Array(groupedData.keys.sorted().enumerated()), id: \.1) { dayIndex, dateString in
                        let forecasts = groupedData[dateString]!
                        
                        LazyVGrid(columns: columns, spacing: 8, pinnedViews: [.sectionHeaders]) {
                            Section(header: ForecastHeaderInfoView(dayIndex: dayIndex)
                            ) {
                                if dayIndex == 0 {
                                    ForecastDetailNowView(weatherNow: weatherNow)
                                }
                                ForEach(forecasts, id: \.date) { forecast in
                                    ForecastDetailView(weather: forecast)
                                }
                            }
                        }
                    }
                    .overlay(GeometryReader { geo in
                        let currentScrollViewPosition = -geo.frame(in: .global).origin.y
                        
                        if currentScrollViewPosition < -amountToPullBeforeRefreshing && !isCurrentlyRefreshing {
                            Color.clear.preference(key: ViewOffsetKeyForecast.self, value: -geo.frame(in: .global).origin.y)
                        }
                    })
                }
                .onPreferenceChange(ViewOffsetKeyForecast.self) { scrollPosition in
                    if scrollPosition < -amountToPullBeforeRefreshing && !isCurrentlyRefreshing {
                        isCurrentlyRefreshing = true
                        Task {
                            await refreshData()
                            await MainActor.run {
                                isCurrentlyRefreshing = false
                            }
                        }
                    }
                }
            }
        }
        .padding(.top, 30)
        .padding()
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct ForecastViewContent_Previews: PreviewProvider {
    static var previews: some View {
        ForecastViewContent(weather: previewForecast, weatherNow: previewWeather)
    }
}
