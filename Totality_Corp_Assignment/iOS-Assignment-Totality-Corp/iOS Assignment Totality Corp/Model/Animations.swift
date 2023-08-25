//
//  Animations.swift
//  iOS Assignment Totality Corp
//
//  Created by Nishay Kumar on 16/08/23.
//

import Foundation
import SwiftUI

//zooming animation

struct ZoomingAnimationModifier: ViewModifier {
    @State private var scale: CGFloat = 0 // Initial scale
    @State private var isContentVisible: Bool = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale) // Apply scale effect
            .animation(.easeInOut(duration: 0.8),value: scale)
            .onAppear {
                // Set the scale to 1 after the animation
                withAnimation {
                    scale = 1
                }
            }
    }
}

extension View {
    func zoomingAnimation() -> some View {
        self.modifier(ZoomingAnimationModifier())
    }
}


//Slide from left to right animation

struct SlideRightAnimationModifier: ViewModifier {
    @Binding var isContentVisible: Bool
    let delay: Double

    func body(content: Content) -> some View {
        content
            .offset(x: isContentVisible ? 0 : 350)
            .animation(.linear(duration: 0.5).delay(delay), value: isContentVisible)
    }
}

extension View {
    func slideInAnimation(isContentVisible: Binding<Bool>, delay: Double) -> some View {
        self.modifier(SlideRightAnimationModifier(isContentVisible: isContentVisible, delay: delay))
    }
}



struct SlideUpAnimationModifier: ViewModifier {
    @Binding var isContentVisible: Bool
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .offset(y: isContentVisible ? 0 : 50)
            .animation(.linear(duration: 0.5).delay(delay), value: isContentVisible)
    }
}

extension View {
    func slideUpAnimation(isContentVisible: Binding<Bool>, delay: Double) -> some View {
        self.modifier(SlideUpAnimationModifier(isContentVisible: isContentVisible, delay: delay))
    }
}
