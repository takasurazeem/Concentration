//
//  Concentration.swift
//  Concentration
//
//  Created by Takasur Azeem on 14/02/2021.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            if let index = newValue {
                cards[index].numberOfTimesWasRevealed += 1
            }
        }
    }
    
    var flipsCount = 0
    var score = 0
    
    private(set) var selectedTheme: GameTheme!
    
    init(numberOfPairOfCards: Int) {
        populateGameThemes()
        assert(gameThemes.count >= 2, "There must be at least two themes to beging the game")
        selectedTheme = gameThemes[Array(gameThemes.keys).randomElement()!]
        assert(selectedTheme.emojis.count >= numberOfPairOfCards, "Number of pairs or cards is more than the emojis in \(selectedTheme!)")
        Card.identifierFactory = 0
        for _ in 0..<numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    /**
     This function checks if there's a match then award a score of two. But if either of card was already seen, it will reduce -1 for each already seen card upon mismatch.
     - Parameter index: Index of the touched card from the interface.
     */
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipsCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, index != matchIndex {
                cards[index].numberOfTimesWasRevealed += 1
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].numberOfTimesWasRevealed > 1 {
                        score = (score - (cards[index].numberOfTimesWasRevealed - 1))
                    }
                    if cards[matchIndex].numberOfTimesWasRevealed > 1 {
                        score = (score - (cards[index].numberOfTimesWasRevealed - 1))
                    }
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    
    // MARK: Game Themes
    /**
     It is Dictionary of emojis in which you pass `card: Card` and it returns an `emoji: String`
     */
    private(set) var emojis = [Card : String]()
    
    /**
     This Function will return an `emoji` for the passed `card` if it cannot find the emoji it will return a `"?"`
     - Parameter card: A card for which an emoji is required.
     - Returns: A `String` emoji from `gameThemes.emojis`
     
     */
    mutating func emoji(for card: Card) -> String {
        if emojis[card] == nil, selectedTheme.emojis.count > 0 {
            let randomStringIndex = selectedTheme.emojis.index(selectedTheme.emojis.startIndex, offsetBy: selectedTheme.emojis.count.arc4random)
            emojis[card] = String(selectedTheme.emojis.remove(at: randomStringIndex))
        }
        return emojis[card] ?? "?"
    }
    
    private var gameThemes = [String:GameTheme]()
    
    mutating func populateGameThemes() {
        gameThemes["faces"] = GameTheme(emojis: "😥😓🤗🤭🤔🤫🤥😶😐😑😬🙄😯😦😧😮🥱😴🤐🤠", primaryColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), backgroundColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
        gameThemes["animals"] = GameTheme(emojis: "🐱🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐵🙈🙉🙊🐒🐔🐧🐤🐣🐥🐝🐛🦋🐞🪲🦕", primaryColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), backgroundColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
        gameThemes["travel"] = GameTheme(emojis: "🚗🚕🚙🏎🚚🛻🚐🚓🚑🚒🚛🚜🛵🏍🛺🚂", primaryColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
        gameThemes["sports"] = GameTheme(emojis: "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🪀🏓🏸🏒🏑🥍🏏🪃🥅⛳️🏹🎣🥊", primaryColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), backgroundColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
        gameThemes["stationary"] = GameTheme(emojis: "📚📖📎🖇📐📏🧮📌📍✂️🖊🖋✒️🖌🖍✏️🔍🔏🔐", primaryColor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), backgroundColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
        gameThemes["flags"] = GameTheme(emojis: "🏳️🏴🏴‍☠️🏁🚩🏳️‍🌈🏳️‍⚧️🇺🇳🇦🇫🇦🇽🇦🇱🇩🇿🇦🇸🇦🇩🇦🇴🇦🇮🇦🇶🇦🇬🇦🇷🇦🇲🇦🇼🇦🇺🇦🇹🇦🇿🇧🇸🇧🇭🇧🇩🇧🇧🇧🇾🇧🇪🇧🇳🇧🇬🇧🇫🇧🇮🇰🇭🇨🇲🇨🇦🇮🇨🇮🇷🇵🇰🇸🇦🇾🇪🇪🇭🇺🇿", primaryColor: #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1), backgroundColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
        gameThemes["planets"] = GameTheme(emojis: "🪐🌏✈️🛩🔭☄️🛸👽🛰👾🚀👩🏼‍🚀🧑🏼‍🚀👨🏼‍🚀", primaryColor: #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1), backgroundColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
        gameThemes["hearts"] = GameTheme(emojis: "❤️🧡💛💚💙💜🖤🤍🤎💔❣️💕💞💓💗💖💘💝💟", primaryColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), backgroundColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
    }
    
}
