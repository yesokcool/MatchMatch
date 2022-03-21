//
//  ContentView.swift
//  Memorize
//
//  Created by Matteo Galli on 3/10/22.
//

import SwiftUI

struct ContentView: View {
    var foodEmojis = ["🍎", "🍊", "🍐", "🍋", "🍓", "🍉",
                  "🥝", "🥐", "🍇", "🍑", "🥕", "🍒",
                  "🍆", "🍅", "🥑", "🥦", "🥬", "🥒",
                  "🌶", "🫑", "🌽", "🧄", "🫒", "🧅",
                  "🥔", "🍠", "🥯", "🍞", "🥖", "🥨"]
    var peopleEmojis = ["😃", "🥹", "🤣", "😂", "😜", "🥸",
                  "😎", "🤩"]
    var animalEmojis = ["🐷", "🙈", "🦄", "🐶", "🐻", "🐙",
                  "🐕", "🦜", "🐿"]
    @State var emojiCount = Int.random(in: 4...8)
    @State var theme = 1
    
    // Returns the theme ID (1, 2, 3) to the given theme's emoji array.
    // If the given theme ID is invalid, the theme defaults to Food.
    func getTheme(_ theme: Int) -> [String] {
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
    }
    
    func gridSize(cardCount: Int) -> CGFloat {
        if (emojiCount < 5) {
            return CGFloat(300/emojiCount)
        }
        else if (emojiCount > 16) {
            return CGFloat(1000/emojiCount)
        }
        return CGFloat(65)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Memorize!")
                    .font(.largeTitle)
                    .fontWeight(.light)
                // LazyVGrid that makes the cards as big as possible without having to scroll.
                LazyVGrid(columns: [GridItem(.adaptive(minimum: gridSize(cardCount: emojiCount)))]) {
                    ForEach(getTheme(theme).shuffled()[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.orange)
            Spacer()
            HStack(alignment: .top) {
                remove
                Spacer()
                foodButton
                Spacer()
                animalButton
                Spacer()
                peopleName
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
            .foregroundColor(.blue)
            
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image (systemName: "minus.circle")
        }
    }
    var add: some View {
        Button {
            if emojiCount < getTheme(theme).count {
                emojiCount += 1
            }
        } label: {
            VStack {
                Image (systemName: "plus.circle")
            }
        }
    }
    var foodButton: some View {
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
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
      
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
        ContentView()
            .preferredColorScheme(.dark)
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
    }
}
