//
//  ErrorInternetConnectionView.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 12.02.2024.
//

import SwiftUI

struct ErrorInternetConnectionView: View {
    let onRefreshTap: () -> Void
    
    
    var body: some View {
        ScrollView{
            
            VStack (
                alignment: .leading,
                spacing: 20
            ){
                
                Image.systemNetworkError
                    .resizable()
                    .scaledToFit()
                    .frame(width: 49)
                
                Text("error.Internet.Connection.Title")
                    .modifier(TitleModifier())
                
                Text("error.Internet.Connection..Message")
                    .modifier(ContentMediumModifier())
                
                HStack {
                    Spacer()
                    
                    Button(action: onRefreshTap) {
                        Image.systemReload
                            .cornerRadius(40)
                            .accentColor(.tabBar)
                        
                    }
                    .buttonStyle(ReloadButton())
                    
                    Spacer()
                }
                
                Spacer()
                
            }
            .padding(.top, 16)
            .padding()
        }
    }
}

#Preview {
    ErrorInternetConnectionView() {
        
    }
}

