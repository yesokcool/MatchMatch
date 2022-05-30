//
//  Cardify.swift
//  Match
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var isMatched: Bool
    var theme: Color?
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else if isMatched {
                shape.opacity(0)
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
                .opacity(isFaceUp ? 1 : 0)
        }
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
