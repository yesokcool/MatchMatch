
//
//  Created on 3/24/22.
//

import Foundation

struct Theme<CardContent> {
    let themeName: String
    let contentSet: [CardContent]
    let numberOfPairsOfCardsToShow: Int
    let themeColor: String
    
    init(themeName: String, contentSet: [CardContent], numberOfPairsOfCardsToShow: Int, themeColor: String) {
        self.themeName = themeName
        self.contentSet = contentSet
        self.numberOfPairsOfCardsToShow = numberOfPairsOfCardsToShow
        self.themeColor = themeColor
    }
    
    init(themeName: String, contentSet: [CardContent], themeColor: String) {
        self.themeName = themeName
        self.contentSet = contentSet
        self.numberOfPairsOfCardsToShow = contentSet.count
        self.themeColor = themeColor
    }
}
