//
//  TodayDetailInfo.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 25.11.2023.
//

import SwiftUI

struct TodayDetailInfo: View {
    
    let weather: CurrentResponse
    
    var body: some View {
        
        Grid (alignment: .leading, horizontalSpacing: 0, verticalSpacing: 8) {
            GridRow {
                TodayDetailInfoLineHumidity
                TodayDetailInfoLinePrecipation
                TodayDetailInfoLinePreasure
            }
            GridRow {
                TodayDetailInfoLineWind
                TodayDetailInfoLineDirection
            }
        }
 
    }
    
    @ViewBuilder
    var TodayDetailInfoLineHumidity: some View {
        VStack (
            alignment: .leading
        ){
            Image(.todayHumidity)
                .imageFrameShape()
            
            Text(weather.main.humidity.roundDouble() + "%")
                .modifier(ContentSmallModifier())
            
            Text("humidity.title")
                .modifier(ContentSmallInfoModifier())
                .fixedSize()
        }
        .frame(width: 109, height: 104, alignment: .leading)
    }
    
    @ViewBuilder
    var TodayDetailInfoLinePrecipation: some View {
        VStack (
            alignment: .leading
        ){
            Image(.todayPrecipitation)
                .imageFrameShape()
            
            Text((String((weather.rain?.oneHour?.rounded() ?? 0))) + "MM")
                .modifier(ContentSmallModifier())
            
            Text("precipitation.title")
                .modifier(ContentSmallInfoModifier())
                .fixedSize()
            
        }
        .padding()
        .frame(width: 109, height: 104, alignment: .leading)
    }
    
    @ViewBuilder
    var TodayDetailInfoLinePreasure: some View {
        VStack (
            alignment: .leading
        ){
            Image(.todayPressure)
                .imageFrameShape()
            
            Text(String(weather.main.pressure.roundDouble()) + "hPa")
                .modifier(ContentSmallModifier())
            
            Text("pressure.title")
                .modifier(ContentSmallInfoModifier())
                .fixedSize()
        }
        .frame(width: 109, height: 104, alignment: .trailing)
    }
    
    @ViewBuilder
    var TodayDetailInfoLineWind: some View {
        VStack (
            alignment: .leading
        ){
            Image(.todayWindSpeed)
                .imageFrameShape()
            
            Text(String(weather.wind.speed.metersPerSecondToKilometersPerHour().roundDouble()) + "KM/H")
                .modifier(ContentSmallModifier())
            
            Text("wind.title")
                .modifier(ContentSmallInfoModifier())
                .fixedSize()
        }
        .frame(width: 109, height: 104, alignment: .leading)
    }
    
    @ViewBuilder
    var TodayDetailInfoLineDirection: some View {
        VStack (
            alignment: .leading
        ){
            Image(.todayWindDirection)
                .imageFrameShape()
            
            Text(weather.wind.windDirection)
                .modifier(ContentSmallModifier())
            
            Text("direction.title")
                .modifier(ContentSmallInfoModifier())
                .fixedSize()
        }
        .padding()
        .frame(width: 109, height: 104, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    TodayDetailInfo(weather: .previewMock)
}
#endif
