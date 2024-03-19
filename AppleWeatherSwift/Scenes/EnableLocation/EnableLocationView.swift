//
//  EnableLocationView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.11.2023.
//

import SwiftUI
import CoreLocationUI

struct EnableLocationView: View {
    
    let locationManager: LocationManager
    
    var body: some View {
        VStack (
            alignment: .leading,
            spacing: 40
        ){
            Image.systemLocation
                .resizable()
                .scaledToFit()
                .frame(width: 49)
            
            Text("enable.Location.Title")
                .modifier(TitleModifier())
                .foregroundColor(.mainText)
            
            
            Text("permission.Message")
                .modifier(ErrorInfoModifier())
            
            Button(action: {
                locationManager.requestLocationRemission()
                print("Button pressed Enable location")
            }) {
                Text("enable.Location.Button.Title")
                    .font(.buttons)
                    .foregroundStyle(.enableLocationButtonText)
            }
            .buttonStyle(EnableButton())
            
            Spacer()
            
        }
        .padding(.top, 100)
    }
}

#Preview {
    EnableLocationView(locationManager: LocationManager())
}
