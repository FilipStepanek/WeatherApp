//
//  ErrorFetchingDataView.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 12.02.2024.
//

import SwiftUI

struct ErrorFetchingDataView: View {
    let onRefreshAction: () -> Void
    
    var body: some View {
        ScrollView{
            ZStack{
                
                VStack (
                    alignment: .leading,
                    spacing: 20
                ){
                    Image.systemWarning
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    
                    Text("error.Fetching.Data.Title")
                        .modifier(TitleModifier())
                    
                    Text("error.Fetching.Data.Message")
                        .modifier(ContentMediumModifier())
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            onRefreshAction()
                        }) {
                            Image.systemReload
                                .cornerRadius(40)
                                .accentColor(.reloadBackground)
                            
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
}

#if DEBUG
#Preview {
    ErrorFetchingDataView(onRefreshAction: {})
}
#endif
