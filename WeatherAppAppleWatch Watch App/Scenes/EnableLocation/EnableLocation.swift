//
//  EnableLocation.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 12.02.2024.
//

import SwiftUI
import CoreLocationUI

struct EnableLocationView: View {
    
    let locationManager: LocationManager
    
    var body: some View {
        ZStack {
            
            ScrollView {
                VStack (
                    alignment: .leading,
                    spacing: 20
                ){
                    Image.systemLocation
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .foregroundColor(.white)
                    
                    Text("enable.Location.Title")
                        .modifier(TitleModifier())
                        .foregroundColor(.mainText)
                    
                    Text("permission.Message")
                        .foregroundColor(.mainText)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                    
                    HStack(alignment: .center){
                        Spacer()
                        
                        Button(action: {
                            locationManager.requestLocationRemission()
                            print("Button pressed Enable location")
                            
                        }) {
                            Text("enable.Location.Button.Title")
                                .modifier(ContentMediumModifierEnable())
    
                        }
                        .buttonStyle(EnableButton())
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    
                }
                .padding()
                .padding(.top, 5)
            }
        }
    }
}

#Preview {
    EnableLocationView(locationManager: LocationManager())
}
