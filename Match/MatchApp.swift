
//
//  Created on 3/10/22.
//

import SwiftUI

@main
struct MatchApp: App {
    // EmojiMemoryGame will change, but `game` is only a pointer that will point to the same thing.
    private let game = SymbolMatchGame(with: Theme<String>(
        themeName: "Food",
        contentSet: ["🍎", "🍊", "🍐", "🍋", "🍓", "🍉",
              "🥝", "🥐", "🍇", "🍑", "🥕", "🍒",
              "🍆", "🍅", "🥑", "🥦", "🥬", "🥒",
              "🌶", "🫑", "🌽", "🧄", "🫒", "🧅",
              "🥔", "🍠", "🥯", "🍞", "🥖", "🥨"],
        numberOfPairsOfCardsToShow: 28,
        themeColor: "Green"))
    
    var body: some Scene {
        WindowGroup {
            SymbolMatchGameView(game: game)
        }
    }
}
