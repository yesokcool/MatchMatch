
//
//  Created on 3/22/22.
//

import Foundation

struct MatchGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int
    private var prevDate = Date()
    private(set) var numberOfGuesses = 0
    private(set) var scoreModifier = 1
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2 * calculateScoreModifier()
                    print("\( Int(prevDate.timeIntervalSinceNow))")
                    scoreModifier *= 2
                }
                else {
                    if (cards[chosenIndex].hasBeenSeen == true) {
                        scoreModifier = max(scoreModifier / 2, 1)
                        score -= 1 * calculateScoreModifier()
                    }
                    else {
                        cards[chosenIndex].hasBeenSeen = true
                    }
                    
                    if (cards[potentialMatchIndex].hasBeenSeen == true) {
                        scoreModifier = max(scoreModifier / 2, 1)
                        score -= 1 * calculateScoreModifier()
                    }
                    else {
                        cards[potentialMatchIndex].hasBeenSeen = true
                    }
                }
                cards[chosenIndex].isFaceUp = true
                numberOfGuesses += 1
            }
            else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                prevDate = Date()
            }
        }
    }
    
    func calculateScoreModifier() -> Int {
        return (max(10 - (-Int(prevDate.timeIntervalSinceNow)), 1)
            * max((cards.count * scoreModifier), 1))
    }
    
    func getScoreModifier() -> Int {
        return scoreModifier
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberofpairsofcards x 2 to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            var content = createCardContent(pairIndex)
            while (cards.contains(where: { card in card.content == content})) {
                content = createCardContent(pairIndex)
            }
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
        score = 0
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false
        let content: CardContent
        let id: Int
    }
}
 
extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
