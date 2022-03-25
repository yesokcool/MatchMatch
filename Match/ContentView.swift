
//
//  Created on 3/10/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SymbolMatchGame
    
    var body: some View {
        VStack {
            ScrollView {
                Text(viewModel.getThemeName())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.getThemeColor())
                HStack {
                Text("Score: \(viewModel.getScore())")
                Text("Guesses: \(viewModel.getNumberOfGuesses())")
                    Text("Modifier: \(viewModel.getScoreModifier())")
                }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, cardTheme: viewModel.getThemeColor())
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.getThemeColor())
        Spacer()
        HStack(alignment: .top) {
            Button {
                viewModel.newGame()
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
        }.padding(.horizontal)
    }
}

struct CardView: View {
    let card: MatchGame<String>.Card
    let cardTheme: Color?
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                if let theme = cardTheme {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SymbolMatchGame(with: Theme<String>(
            themeName: "People",
            contentSet: ["😃", "🥹", "🤣", "😂", "😜", "🥸","😎", "🤩"],
            numberOfPairsOfCardsToShow: Int.random(in: 4...8),
            themeColor: "Yellow"))
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portrait)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game).previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
    }
}
