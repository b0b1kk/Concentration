//
//  Theme.swift
//  Concentration
//
//  Created by Bogdan Mishura on 7/13/19.
//  Copyright © 2019 Bogdan Mishura. All rights reserved.
//

import Foundation
import UIKit


struct Theme {
    var emojiForButton: String
    var mainColor: UIColor
    var backGroundColor: UIColor


    static var themeArray: [Theme] = [
    Theme(emojiForButton: "👻🎃🥶😱👹😈🤡👽💀👾", mainColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), backGroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
    Theme(emojiForButton: "😃🤪😎🤩🤓😏🤣😇🥺🥳",
      mainColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), backGroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),
    Theme(emojiForButton: "⚽️🏀🏈🥍🥎🏓🏐🏉🥏🎱", mainColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), backGroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
]
}

