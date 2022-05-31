
//
//  Created on 3/10/22.
//

import SwiftUI

struct SymbolMatchGameView: View {
    @ObservedObject var game: SymbolMatchGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameTitle
                gameBody
                gameControls
                    .padding()
                
                Spacer()
            }
            deckBody
        }
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: SymbolMatchGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: SymbolMatchGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
        
    var gameTitle: some View {
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
        .foregroundColor(game.getThemeColor())
        .padding()
    }
    
    var gameControls: some View {
        HStack(alignment: .top) {
            Button {
                withAnimation {
                    dealt = []
                    game.newGame()
                }
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "gamecontroller.fill")
                    Text ("New Game")
                        .font(.caption)
                }
            }
            Spacer()
            shuffle
        }
        .font(.largeTitle)
        .padding(.horizontal)
        .foregroundColor(.blue)
    }
    
    private func dealAnimation(for card: SymbolMatchGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: SymbolMatchGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            }
            else {
                CardView(card: card, theme: game.getThemeColor())
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card, theme: game.getThemeColor())
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(game.getThemeColor())
        .onTapGesture {
            // deal cards
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button() {
            withAnimation() {
                game.shuffle()
            }
        } label: {
            VStack(alignment: .center) {
                Image(systemName: "rectangle.2.swap")
                Text ("Shuffle")
                    .font(.caption)
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
        
    }
}

struct CardView: View {
    let card: SymbolMatchGame.Card
    let theme: Color?
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    }
                    else {
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                .padding(5)
                .opacity(0.5)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(Font.system(size:DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched, theme: theme)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
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
