
//
//  Created on 3/10/22.
//

import SwiftUI

@main
struct MatchApp: App {
    // EmojiMemoryGame will change, but `game` is only a pointer that will point to the same thing.
    let game = SymbolMatchGame(with: Theme<String>(
        themeName: "People",
        contentSet: ["😃", "🥹", "🤣", "😂", "😜", "🥸","😎", "🤩"],
        numberOfPairsOfCardsToShow: Int.random(in: 4...8),
        themeColor: "Yellow"))
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
