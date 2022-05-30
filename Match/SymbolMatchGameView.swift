
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
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 360-90))
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                        .font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched, theme: theme)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
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
