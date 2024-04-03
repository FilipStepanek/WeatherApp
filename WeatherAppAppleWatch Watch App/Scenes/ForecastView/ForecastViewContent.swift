//
//  ForecastViewContent.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 13.02.2024.
//

import SwiftUI

struct ForecastViewContent: View {
    let weather: ForecastResponse
    let weatherNow: CurrentResponse
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
            
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(Array(groupedData.keys.sorted().enumerated()), id: \.1) { dayIndex, dateString in
                        let forecasts = groupedData[dateString]!
                        
                        LazyVGrid(columns: columns, spacing: 8) {
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
                }
            }
        }
        .padding(.top, 45)
        .padding()
        .background(.mainBackground)
        .ignoresSafeArea(.all)
    }
}

#if DEBUG
#Preview {
    ForecastViewContent(
        weather: .previewMock,
        weatherNow: .previewMock
    )
}
#endif
