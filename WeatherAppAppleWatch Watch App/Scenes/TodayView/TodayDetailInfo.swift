//
//  TodayDetailInfo.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 12.02.2024.
//

import SwiftUI

struct TodayDetailInfo: View {
    
    let weather: ResponseData.CurrentResponse
    
    var body: some View {
        ScrollView{
            VStack(
                alignment: .leading,
                spacing: 20
            ){
                todayDetailInfoLineOne
                
                .padding(.vertical, 10)
                
                todayDetailInfoLineTwo
                
                todayDetailInfoLineThree
               
            }
            .background(.mainBackground)
        }
    }
    
    @ViewBuilder
    var todayDetailInfoLineOne: some View {
        HStack(
            spacing: 50
        ){
            VStack (
                alignment: .leading
            ){
                Image(.todayHumidity)
                    .imageFrameShape()
                
                Text(weather.main.humidity.roundDouble() + "%")
                    .modifier(ContentSmallModifier())
                
                Text("humidity.title")
                    .modifier(ContentSmallInfoModifier())
            }
            
            VStack (
                alignment: .leading
            ){
                Image(.todayPrecipitation)
                    .imageFrameShape()
                
                Text((String((weather.rain?.oneHour?.rounded() ?? 0))) + "MM")
                    .modifier(ContentSmallModifier())
                
                Text("precipitation.title")
                    .modifier(ContentSmallInfoModifier())
            }
        }
    }
    
    @ViewBuilder
    var todayDetailInfoLineTwo: some View {
        HStack(
            spacing: 50
        ){
            VStack (
                alignment: .leading
            ){
                Image(.todayPressure)
                    .imageFrameShape()
                
                Text(String(weather.main.pressure.roundDouble()) + "hPa")
                    .modifier(ContentSmallModifier())
                
                Text("pressure.title")
                    .modifier(ContentSmallInfoModifier())
            }
            
            VStack (
                alignment: .leading
            ){
                Image(.todayWindSpeed)
                    .imageFrameShape()
                
                Text(String(weather.wind.speed.metersPerSecondToKilometersPerHour().roundDouble()) + "KM/H")
                    .modifier(ContentSmallModifier())
                
                Text("wind.title")
                    .modifier(ContentSmallInfoModifier())
            }
        }    }
    
    @ViewBuilder
    var todayDetailInfoLineThree: some View {
        HStack()
        {
            VStack (
                alignment: .leading
            ){
                Image(.todayWindDirection)
                    .imageFrameShape()
                
                Text(weather.wind.windDirection)
                    .modifier(ContentSmallModifier())
                
                Text("direction.title")
                    .modifier(ContentSmallInfoModifier())
            }
        }
    }
}

#Preview {
    TodayDetailInfo(weather: previewWeather)
}
