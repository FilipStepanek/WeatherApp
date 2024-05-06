//
//  OnLoadModifier.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 19.03.2024.
//

// TODO: Is it used????
import SwiftUI

public struct OnLoadModifier {
    // MARK: Properties
    @State private var didLoad = false
    
    public let action: () -> Void
    
    // MARK: Init
    public init(action: @escaping () -> Void) {
        self.action = action
    }
}

// MARK: ViewModifier
extension OnLoadModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .onAppear {
                guard !didLoad else {
                    return
                }
                
                didLoad = true
                
                action()
            }
    }
}

// MARK: View + onLoad
public extension View {
    func onLoad(perform action: @escaping () -> Void) -> some View {
        modifier(OnLoadModifier(action: action))
    }
}
