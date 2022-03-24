//
//  ContentView.swift
//  Memorize
//
//  Created on 3/10/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    // Returns the theme ID (1, 2, 3) to the given theme's emoji array.
    // If the given theme ID is invalid, the theme defaults to Food.
    /*func getTheme(_ theme: Int) -> [String] {
        var emojis: [String]
        switch theme {
        case 1:
            emojis = foodEmojis
        case 2:
            emojis = peopleEmojis
        case 3:
            emojis = animalEmojis
        default:
            emojis = foodEmojis
        }
        return emojis
    }*/
    
    /*func gridSize(cardCount: Int) -> CGFloat {
        if (emojiCount < 5) {
            return CGFloat(300/emojiCount)
        }
        else if (emojiCount > 16) {
            return CGFloat(1000/emojiCount)
        }
        return CGFloat(65)
    }*/
    
    var body: some View {
        //VStack {
            ScrollView {
                Text("Memorize!")
                    .font(.largeTitle)
                    .fontWeight(.light)
                // LazyVGrid that makes the cards as big as possible without having to scroll.
                //LazyVGrid(columns: [GridItem(.adaptive(minimum: gridSize(cardCount: emojiCount)))]) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    //ForEach(getTheme(viewModel.cards) { card in
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
           // }
            .foregroundColor(.orange)
                            }
                            /*
            Spacer()
            HStack(alignment: .top) {
                Spacer()
                //foodButton
                Spacer()
                //animalButton
                Spacer()
                //peopleName
                Spacer()
            }
            .font(.largeTitle)
            .padding(.horizontal)
            .foregroundColor(.blue)
            
        }*/
        .padding(.horizontal)
    }
    /*var foodButton: some View {
        Button {
            emojiCount = Int.random(in: 4...8)
            theme = 1
        } label: {
            VStack(alignment: .center) {
                Image(systemName: "fork.knife.circle.fill")
                Text ("Food")
                    .font(.caption)
            }
        }
    }
    var peopleName: some View {
        Button {
            emojiCount = Int.random(in: 4...8)
            theme = 2
        } label: {
            VStack(alignment: .center) {
                Image(systemName: "figure.walk.circle.fill")
                Text ("People")
                    .font(.caption)
            }
        }
    }
    var animalButton: some View {
        Button {
            emojiCount = Int.random(in: 4...8)
            theme = 3
        } label: {
            VStack(alignment: .center) {
                Image(systemName: "pawprint.circle.fill")
                Text ("Animal")
                    .font(.caption)
            }
        }
    }*/
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portraitUpsideDown)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game).previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
    }
}
