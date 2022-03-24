
//
//  Created on 3/22/22.
//

import SwiftUI

class SymbolMatchGame: ObservableObject {

    @Published private var theme: Theme<String>
    @Published private var model: MatchGame<String>
    @Published private var themes: [Theme<String>]
    
    init(with chosenTheme: Theme<String>) {
        theme = chosenTheme
        model = SymbolMatchGame.createMemoryGame(with: chosenTheme)
        themes =
        [Theme<String>(
            themeName: "People",
            contentSet: ["😃", "🥹", "🤣", "😂", "😜", "🥸","😎", "🤩"],
            numberOfPairsOfCardsToShow: Int.random(in: 4...8),
            themeColor: "Yellow"),
         Theme<String>(
             themeName: "Animals",
             contentSet: ["🐷", "🙈", "🦄", "🐶", "🐻",
                   "🐙", "🐕", "🦜", "🐿"],
             numberOfPairsOfCardsToShow: Int.random(in: 4...8),
             themeColor: "Blue"),
         Theme<String>(
             themeName: "Food",
             contentSet: ["🍎", "🍊", "🍐", "🍋", "🍓", "🍉",
                   "🥝", "🥐", "🍇", "🍑", "🥕", "🍒",
                   "🍆", "🍅", "🥑", "🥦", "🥬", "🥒",
                   "🌶", "🫑", "🌽", "🧄", "🫒", "🧅",
                   "🥔", "🍠", "🥯", "🍞", "🥖", "🥨"],
             numberOfPairsOfCardsToShow: Int.random(in: 4...8),
             themeColor: "Green")]
    }
    
    static func createMemoryGame(with theme: Theme<String>) -> MatchGame<String> {
        
        let numberOfPairsOfCardsToShow: Int
        if theme.numberOfPairsOfCardsToShow > theme.contentSet.count {
            numberOfPairsOfCardsToShow = theme.contentSet.count
        } else {
            numberOfPairsOfCardsToShow = theme.numberOfPairsOfCardsToShow
        }
        return MatchGame<String>(numberOfPairsOfCards: numberOfPairsOfCardsToShow) { pairIndex in
            theme.contentSet.randomElement()!}
    }
    
    func newGame() {
        
        let newTheme = themes[Int.random(in: 0..<themes.count)]
        
        let numberOfPairsOfCardsToShow: Int
        if newTheme.numberOfPairsOfCardsToShow > newTheme.contentSet.count {
            numberOfPairsOfCardsToShow = newTheme.contentSet.count
        } else {
            numberOfPairsOfCardsToShow = newTheme.numberOfPairsOfCardsToShow
        }
        
        theme = newTheme
        model = MatchGame<String>(numberOfPairsOfCards: numberOfPairsOfCardsToShow) { pairIndex in
            newTheme.contentSet.randomElement()!}
    }
    
    var cards: Array<MatchGame<String>.Card> {
        return model.cards
    }
    
    func getThemeName() -> String {
        return theme.themeName
    }
    
    func getThemeColor() -> Color {
        switch theme.themeColor {
        case "Blue":
            return .blue
        case "Green":
            return .green
        case "Yellow":
            return .yellow
        default:
            return .blue
        }
    }
    
    func getScore() -> Int {
        return model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MatchGame<String>.Card) {
        model.choose(card)
    }
}
