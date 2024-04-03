//
//  ErrorInternetConnectionView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 19.01.2024.
//

import SwiftUI

struct ErrorInternetConnectionView: View {
    let onRefreshTap: () -> Void
    
    var body: some View {
        
        VStack (
            alignment: .leading,
            spacing: 40
        ){
            HStack {
                Spacer()
                
                Button(action: onRefreshTap) {
                    Image.systemReload
                        .cornerRadius(40)
                        .accentColor(.tabBar)
                    
                }
                .buttonStyle(ReloadButton())
            }
            
            Image.systemNetworkError
                .resizable()
                .scaledToFit()
                .frame(width: 49)
            
            Text("error.Internet.Connection.Title")
                .modifier(TitleModifier())
                .foregroundColor(.mainText)
            
            Text("error.Internet.Connection..Message")
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
    ErrorInternetConnectionView(onRefreshTap: {})
}
#endif
