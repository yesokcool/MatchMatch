//
//  Cardify.swift
//  Match
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var isMatched: Bool
    var theme: Color?
    
    var rotation: Double // in degrees
    
    init(isFaceUp: Bool, isMatched: Bool, theme: Color?) {
        rotation = isFaceUp ? 0 : 180
        self.isMatched = isMatched
        self.theme = theme
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else if isMatched {
                shape.opacity(rotation < 90 ? 1 : 0)
            }
            else {
                if let theme = theme {
                    shape.fill(theme)
                } else {
                    shape.fill(LinearGradient(gradient: Gradient(colors: [.blue, .orange]),
                                              startPoint: .top,
                                              endPoint: .bottom))
                }
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool, theme: Color?) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched, theme: theme))
    }
}
