//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Matteo Galli on 3/10/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    // EmojiMemoryGame will change, but `game` is only a pointer that will point to the same thing.
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
