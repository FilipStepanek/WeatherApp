//
//  ButtonExtension.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 18.01.2024.
//

import SwiftUI

public extension Button {
    func presentShareModalOnTap(
        activityItems: [Any],
        completion: UIActivityViewController.CompletionWithItemsHandler? = nil
    ) -> some View {
        self.buttonStyle(ShareButtonStyle(activityItems: activityItems, completion: completion))
    }
}

private struct ShareButtonStyle: ButtonStyle {
    let activityItems: [Any]
    let completion: UIActivityViewController.CompletionWithItemsHandler?
    
    @State private var wasPressed = false
    @State private var isPresented = false
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        
        return configuration.label
            .opacity(configuration.isPressed ? 0.3 : 1)
            .background(
                UIKitActivityView(
                    isPresented: $isPresented,
                    completion: completion,
                    activityItems: activityItems
                )
            )
            .onChange(of: configuration.isPressed) { newValue in
                // We want to present the share modal when user releases the button
                if wasPressed && !newValue {
                    isPresented = true
                }
                
                wasPressed = newValue
            }
    }
}

private struct UIKitActivityView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    
    let completion: UIActivityViewController.CompletionWithItemsHandler?
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard isPresented && uiViewController.presentedViewController == nil else {
            return
        }
        
        let activityViewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceView = uiViewController.view
        activityViewController.completionWithItemsHandler = { (activityType, success, items, error) in
            isPresented = false
            completion?(activityType, success, items, error)
        }
        
        uiViewController.present(activityViewController, animated: true)
    }
}
