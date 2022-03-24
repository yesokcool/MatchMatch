
//
//  Created on 3/24/22.
//

import Foundation

struct Theme<CardContent> {
    let themeName: String
    let contentSet: [CardContent]
    let numberOfPairsOfCardsToShow: Int
    let themeColor: String
}
