//
//  ViewController.swift
//  Concentration
//
//  Created by Bogdan Mishura on 7/12/19.
//  Copyright © 2019 Bogdan Mishura. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

   private lazy var game = Concentration(numbersOfCardPair: numberOfCardPairs)
    
    var numberOfCardPairs: Int {
        return (cardButtonsArray.count + 1) / 2
    }
    
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtonsArray: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theme()
        uploadViewFromModel()
    }
    
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtonsArray.firstIndex(of: sender) {
            game.choiseCard(at: cardNumber)
            uploadViewFromModel()
            
        } else {
            print("Cant find card index in array")
        }
    }
    
    @IBAction private func newGameButton(_ sender: UIButton) {
        newGame()
        theme()
        uploadViewFromModel()
    }
    
  private func newGame() {
        for index in game.cards.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            game.cards[index].flipCountForScore = 0
        }
        emoji = [:]
        game.scoreCount = 0
        game.flipCount = 0
    }
    
    
   private func uploadViewFromModel() {
        scoreLabel.text = "Score: \(game.scoreCount)"
        flipCountLabel.text = "Flip count: \(game.flipCount)"
        for cardIndex in cardButtonsArray.indices {
            let card = game.cards[cardIndex]
            let button = cardButtonsArray[cardIndex]
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitle(emoji(for: card), for: .normal)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : colorMain
            }
        }

    }
    
   private func theme() {
    
    var attributes: [NSAttributedString.Key: Any] = [.strokeWidth: 5.0, .strokeColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
    let attributeStringFlipCount = NSAttributedString(string: "Flip count: \(game.flipCount)", attributes: attributes)
    let attributeStringScore = NSAttributedString(string: "Score: \(game.scoreCount)", attributes: attributes)
    let attributeStringButton = NSAttributedString(string: "New Game", attributes: attributes)

    flipCountLabel.attributedText = attributeStringFlipCount
    scoreLabel.attributedText = attributeStringScore
    newGameButton.setAttributedTitle(attributeStringButton, for: .normal)
    
        switch Theme.themeArray.count.arc4random {
        case 0:
            emojiChoise = Theme.themeArray[0].emojiForButton
            colorMain = Theme.themeArray[0].mainColor
            view.backgroundColor = Theme.themeArray[0].backGroundColor
            attributes[.strokeColor] = colorMain
            
        case 1:
            emojiChoise = Theme.themeArray[1].emojiForButton
            colorMain = Theme.themeArray[1].mainColor
            view.backgroundColor = Theme.themeArray[1].backGroundColor
            attributes[.strokeColor] = colorMain

        case 2:
            emojiChoise = Theme.themeArray[2].emojiForButton
            colorMain = Theme.themeArray[2].mainColor
            view.backgroundColor = Theme.themeArray[2].backGroundColor
            attributes[.strokeColor] = colorMain

        default:
            print("random index out of range")
        }
    }
    
    private var emojiChoise = ""
   private var colorMain = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
   private var emoji = [Card: String]()
    
   private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoise.count > 0 {
            let randomStringIndex = emojiChoise.index(emojiChoise.startIndex, offsetBy: emojiChoise.count.arc4random)
            emoji[card] = String(emojiChoise.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "??"
    }
    
    
}

extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}
