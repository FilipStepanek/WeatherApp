//
//  ErrorFetchingDataView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.11.2023.
//

import SwiftUI
import OSLog

struct ErrorFetchingDataView: View {
    
    @StateObject private var viewModelToday = TodayViewModel()
    @StateObject private var viewModelForecast = ForecastViewModel()
    
    var body: some View {
        VStack (
            alignment: .leading,
            spacing: 40
        ){
            HStack {
                Spacer()
                
                Button(action: {
                    Logger.viewCycle.info("Button pressed Reload")
                    
                    Task {
                        await viewModelForecast.initialLoad()
                    }
                }) {
                    Image.systemReload
                        .cornerRadius(40)
                        .accentColor(.tabBar)
                    
                }
                .buttonStyle(ReloadButton())
            }
            
            Image.systemWarning
                .resizable()
                .scaledToFit()
                .frame(width: 49)
            
            Text("error.Fetching.Data.Title")
                .modifier(TitleModifier())
                .foregroundColor(.mainText)
            
            Text("error.Fetching.Data.Message")
                .modifier(ErrorInfoModifier())
            
            Spacer()
            
        }
        .padding(.top, 16)
        .padding()
        .background(
            ErrorAnimationBackgroundView()
        )
    }
}

#if DEBUG
#Preview {
    ErrorFetchingDataView()
}
#endif
