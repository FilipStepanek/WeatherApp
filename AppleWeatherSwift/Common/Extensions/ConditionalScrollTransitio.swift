//
//  ConditionalScrollTransitio.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 27.05.2024.
//

import SwiftUI

struct ConditionalScrollTransition: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content.scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1.0 : 0.3)
                    .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
            }
        } else {
            GeometryReader { proxy in
                let frame = proxy.frame(in: .global)
                content
                    .opacity(opacity(for: frame))
                    .scaleEffect(scale(for: frame))
            }
        }
    }

    private func opacity(for frame: CGRect) -> Double {
        let minY = frame.minY
        let maxY = frame.maxY
        let visibleThreshold = UIScreen.main.bounds.height

        if minY >= 0 && maxY <= visibleThreshold {
            return 1.0
        } else {
            return 0.3
        }
    }

    private func scale(for frame: CGRect) -> CGFloat {
        let minY = frame.minY
        let maxY = frame.maxY
        let visibleThreshold = UIScreen.main.bounds.height

        if minY >= 0 && maxY <= visibleThreshold {
            return 1.0
        } else {
            return 0.8
        }
    }
}
