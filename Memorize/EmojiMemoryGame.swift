//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created on 3/22/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static let foodEmojis = ["🍎", "🍊", "🍐", "🍋", "🍓", "🍉",
                  "🥝", "🥐", "🍇", "🍑", "🥕", "🍒",
                  "🍆", "🍅", "🥑", "🥦", "🥬", "🥒",
                  "🌶", "🫑", "🌽", "🧄", "🫒", "🧅",
                  "🥔", "🍠", "🥯", "🍞", "🥖", "🥨"]
    let peopleEmojis = ["😃", "🥹", "🤣", "😂", "😜", "🥸",
                  "😎", "🤩"]
    let animalEmojis = ["🐷", "🙈", "🦄", "🐶", "🐻", "🐙",
                  "🐕", "🦜", "🐿"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            EmojiMemoryGame.foodEmojis[pairIndex]}
    }
     
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
