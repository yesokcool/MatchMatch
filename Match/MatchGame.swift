
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
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content
                {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2 * calculateScoreModifier()
                    print("\( Int(prevDate.timeIntervalSinceNow))")
                    scoreModifier *= 2
                } else {
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
                numberOfGuesses += 1
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                prevDate = Date()
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        /*
        print("\(score)")
        print("\(  max(10 - (-Int(prevDate.timeIntervalSinceNow)), 1)  )")
        print("\(  max(cards.count - modifierScore, 1)  )")*/
    }
    
    func calculateScoreModifier() -> Int {
        return (max(10 - (-Int(prevDate.timeIntervalSinceNow)), 1)
            * max((cards.count * scoreModifier), 1))
    }
    
    func getScoreModifier() -> Int {
        return scoreModifier
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
 
