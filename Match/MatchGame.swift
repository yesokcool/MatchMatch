
//
//  Created on 3/22/22.
//

import Foundation

struct MatchGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int
    
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
                    score += 2
                } else {
                    if (cards[chosenIndex].hasBeenSeen == true) {
                        score -= 1
                    }
                    else {
                        cards[chosenIndex].hasBeenSeen = true
                    }
                    
                    if (cards[potentialMatchIndex].hasBeenSeen == true) {
                        score -= 1
                    }
                    else {
                        cards[potentialMatchIndex].hasBeenSeen = true
                    }
                }

                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        
        print("\(cards)")
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
 
