//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created on 3/22/22.
//

import SwiftUI

class EmojiMemoryGame {
    
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
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
