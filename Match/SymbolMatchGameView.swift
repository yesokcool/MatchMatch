
//
//  Created on 3/10/22.
//

import SwiftUI

struct SymbolMatchGameView: View {
    @ObservedObject var game: SymbolMatchGame
    
    var body: some View {
        VStack {
            VStack {
                Text(game.getThemeName())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(game.getThemeColor())
                Text("SCORE: \(game.getScore())")
                    .font(.title3)
                    .fontWeight(.semibold)
                HStack {
                    Text("Guesses: \(game.getNumberOfGuesses())")
                    Text("Modifier: \(game.getScoreModifier())")
                }
                .font(.subheadline)
            }
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                }
                else {
                    CardView(card: card, theme: game.getThemeColor())
                        .padding(4)
                        .onTapGesture { game.choose(card) }
                }
            }.padding(.horizontal)
            
            HStack(alignment: .top) {
                Button {
                    game.newGame()
                } label: {
                    VStack(alignment: .center) {
                        Image(systemName: "gamecontroller.fill")
                        Text ("New Game")
                            .font(.caption)
                    }
                }
            }
            .font(.largeTitle)
            .padding(.horizontal)
            .foregroundColor(.blue)
            
            Spacer()
        }
        .foregroundColor(game.getThemeColor())
    }
}

struct CardView: View {
    let card: SymbolMatchGame.Card
    let theme: Color?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 360-90))
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    if let theme = self.theme {
                        shape.fill(theme)
                    } else {
                        shape.fill(LinearGradient(gradient: Gradient(colors: [.blue, .orange]),
                                                  startPoint: .top,
                                                  endPoint: .bottom))
                    }
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SymbolMatchGame(with: Theme<String>(
            themeName: "People",
            contentSet: ["😃", "🥹", "🤣", "😂", "😜", "🥸","😎", "🤩"],
            numberOfPairsOfCardsToShow: Int.random(in: 4...8),
            themeColor: "Yellow"))
        game.choose(game.cards.first!)
        return SymbolMatchGameView(game: game)
    }
}
