//
//  Card.swift
//  Concentration
//
//  Created by Bogdan Mishura on 7/12/19.
//  Copyright © 2019 Bogdan Mishura. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    var flipCountForScore = 0
    
    private static var uniqeIdentifier = 0
    
    private static func getUniqueIdentifier() -> Int{
        uniqeIdentifier += 1
        return uniqeIdentifier
    }
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
}
