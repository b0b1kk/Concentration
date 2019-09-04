//
//  Concentration.swift
//  Concentration
//
//  Created by Bogdan Mishura on 7/12/19.
//  Copyright © 2019 Bogdan Mishura. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    private var oneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter() {cards[$0].isFaceUp}.oneAndOnly
            
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    var scoreCount = 0
    var flipCount = 0
    
    func choiseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = oneAndOnlyFaceUpCard, matchIndex != index {
                if  cards[matchIndex] == cards[index] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    scoreCount += 2
                }
                cards[index].isFaceUp = true
                
                cards[index].flipCountForScore += 1
                cards[matchIndex].flipCountForScore += 1
                flipCount += 1
            } else {
                flipCount += 1
                cards[index].flipCountForScore += 1
                
                oneAndOnlyFaceUpCard = index
            }
            if cards[index].flipCountForScore > 1 {
                scoreCount -= 1
            }
        }
    }
    
    init(numbersOfCardPair: Int) {
        for _ in 1...numbersOfCardPair{
            let card = Card()
            cards += [card, card]
            cards = cards.shuffled()
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
