//
//  ViewExtensions.swift
//  POC-SwiftUI
//
//  Created by User on 07/07/2024.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct ShadowView<T: Shape>: ViewModifier {
    
    // MARK: - Variables
    let shape: T
    
    var xOffset: CGFloat
    var yOffset: CGFloat
    
    var opacity: Double
    var lineWidth: CGFloat = 3
    
    var backgroundColor: Color
    
    var needsBrightness: Bool
    var colorScheme: ColorScheme
    
    init(xOffset: CGFloat, yOffset: CGFloat, lineWidth: CGFloat = 3, opacity: Double = 1, backgroundColor: Color = Color.background, needsBrightness: Bool = false, colorScheme: ColorScheme, @ViewBuilder shapeView: () -> T) {
        self.xOffset = xOffset
        self.yOffset = yOffset
        
        self.lineWidth = lineWidth
        self.opacity = opacity
        
        self.backgroundColor = backgroundColor
        self.needsBrightness = needsBrightness
        
        self.colorScheme = colorScheme
        
        self.shape = shapeView()
    }
    
    // MARK: - Functions
    func body(content: Content) -> some View {
        ZStack {
            shape
                .offset(x: xOffset, y: yOffset)
                .opacity(opacity)
            
            shape
                .foregroundColor(backgroundColor)
                .if(needsBrightness, transform: { view in
                    view
                        .brightness(0.075)
                })
                    
            shape
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            .opacity(opacity)
            
            content
        }
        .zIndex(4)
        .colorScheme(colorScheme)
    }
}
extension View {
    func shadowOverlay<V: Shape>(xOffset: CGFloat = 9, yOffset: CGFloat = 10, lineWidth: CGFloat = 3, opacity: Double = 1, backgroundColor: Color = Color.background, needsBrightness: Bool = false, colorScheme: ColorScheme, content: V) -> some View {
        modifier(
            ShadowView(xOffset: xOffset, yOffset: yOffset, lineWidth: lineWidth, opacity: opacity, backgroundColor: backgroundColor, needsBrightness: needsBrightness, colorScheme: colorScheme) {
                content
            }
        )
    }
}

extension Shape {
    func shadowShapeOverlay(xOffset: CGFloat = 9, yOffset: CGFloat = 10, colorScheme: ColorScheme) -> some View {
        modifier(
            ShadowView(xOffset: xOffset, yOffset: yOffset, colorScheme: colorScheme) {
                self
            }
        )
    }
}
