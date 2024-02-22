//
//  ShareSheetView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 05.12.2023.
//

import SwiftUI

struct ShareSheetView: UIViewControllerRepresentable {
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
