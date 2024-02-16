//
//  ForecastDayInfoView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 28.11.2023.
//

import SwiftUI

struct ForecastHeaderInfoView: View {
    
    let dayIndex: Int
    
    var body: some View {
        HStack() {
            Text(dayHeaderText())
                .foregroundStyle(.mainText)
                .font(.dayInfo)
            
            Spacer()
            
            Text(currentDate(for: dayIndex))
                .modifier(ContentSmallInfoModifier())
        }
        
        .padding([.top,.bottom], 16)
        .background(.mainBackground)
    }
    
    func currentDate(for dayIndex: Int) -> String {
        let date = Calendar.current.date(byAdding: .day, value: dayIndex, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM "
        return formatter.string(from: date)
    }
    
    func dayHeaderText() -> String {
        switch dayIndex {
        case 0:
            return String(localized: "today.day.info")
        case 1:
            return String(localized: "tomorrow.day.info")
        default:
            let date = Calendar.current.date(byAdding: .day, value: dayIndex, to: Date()) ?? Date()
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            return dayFormatter.string(from: date)
        }
    }
}

#Preview {
    ForecastHeaderInfoView(dayIndex: 0)
}
