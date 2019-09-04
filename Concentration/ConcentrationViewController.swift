//
//  ViewController.swift
//  Concentration
//
//  Created by Bogdan Mishura on 7/12/19.
//  Copyright © 2019 Bogdan Mishura. All rights reserved.
//

import UIKit

class ConcentrationViewController: VCLLoggingViewController {
    
    override var vclLoggingName: String {
        return "Game"
    }
    
    var theme: String? {
        didSet {
            emojiChoise = theme ?? ""
            emoji = [:]
            updateFocusIfNeeded()
        }
    }
    
    private lazy var game = Concentration(numbersOfCardPair: numberOfCardPairs)
    
    var numberOfCardPairs: Int {
        return (cardsButtonsArray.count + 1) / 2
    }
    
    //bottom stackview
    let newsGameButton = UIButton()
    let flipCountsLabel = UILabel()
    let scoresLabel = UILabel()
    
    var stackViewOfBottomElement = UIStackView()
    
    func bottomStackView() {
        stackViewOfBottomElement.addArrangedSubview(scoresLabel)
        stackViewOfBottomElement.addArrangedSubview(flipCountsLabel)
        stackViewOfBottomElement.addArrangedSubview(newsGameButton)
        
        stackViewOfBottomElement.axis = .vertical
        stackViewOfBottomElement.distribution = .fillEqually
        stackViewOfBottomElement.alignment = .center
        stackViewOfBottomElement.spacing = 5
        stackViewOfBottomElement.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewOfBottomElement)
        
    }
    
    //top stackview
    var cardsButtonsArray: [UIButton] = {
        var cardsButtonsArray = [UIButton]()
        for _ in 1...20 {
            let button = UIButton()
            button.titleLabel?.font = .systemFont(ofSize: 25)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(touchCard(_:)), for: .touchUpInside)
            cardsButtonsArray.append(button)
        }
        return cardsButtonsArray
    }()
    
    var stackViewOfButtons = [UIStackView]()
    var stackViewForTopButtons = UIStackView()
    
    func createHorizontalStackView() {
        var arrayButtons = [[UIButton](), [UIButton](), [UIButton](), [UIButton](), [UIButton]()]
        
        for i in cardsButtonsArray.indices {
            switch i {
            case 0..<4:
                arrayButtons[0].append(cardsButtonsArray[i])
            case 4...7:
                arrayButtons[1].append(cardsButtonsArray[i])
            case 8...11:
                arrayButtons[2].append(cardsButtonsArray[i])
            case 12...15:
                arrayButtons[3].append(cardsButtonsArray[i])
            case 15...19:
                arrayButtons[4].append(cardsButtonsArray[i])
            default:
                break
            }
        }
        for i in arrayButtons.indices {
            let subStackView = UIStackView(arrangedSubviews: arrayButtons[i])
            subStackView.axis = .horizontal
            subStackView.distribution = .fillEqually
            subStackView.spacing = 8
            stackViewOfButtons.append(subStackView)
        }
        
    }
    
    func createVerticalStackView() {
        stackViewForTopButtons = UIStackView(arrangedSubviews: stackViewOfButtons)
        stackViewForTopButtons.axis = .vertical
        stackViewForTopButtons.distribution = .fillEqually
        stackViewForTopButtons.spacing = 8
        stackViewForTopButtons.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewForTopButtons)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes: [NSAttributedString.Key: Any] = [.strokeWidth: 5.0, .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        let attributeStringFlipCount = NSAttributedString(string: "Flip count: \(game.flipCount)", attributes: attributes)
        let attributeStringScore = NSAttributedString(string: "Score: \(game.scoreCount)", attributes: attributes)
        let attributeStringButton = NSAttributedString(string: "New Game", attributes: attributes)
        
        flipCountsLabel.attributedText = attributeStringFlipCount
        scoresLabel.attributedText = attributeStringScore
        newsGameButton.setAttributedTitle(attributeStringButton, for: .normal)
        
        createHorizontalStackView()
        createVerticalStackView()
        
        bottomStackView()
        newsGameButton.addTarget(self, action: #selector(newGameButton(_:)), for: .touchUpInside)
        
        uploadViewFromModel()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        uploadViewFromModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //create constraint for top stackview
        stackViewForTopButtons.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        stackViewForTopButtons.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        stackViewForTopButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stackViewForTopButtons.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
        
        //create constraint for bottom stackview
        stackViewOfBottomElement.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 108).isActive = true
        stackViewOfBottomElement.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -108).isActive = true
        stackViewOfBottomElement.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        stackViewOfBottomElement.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 580).isActive = true
        
        
    }
    
    
    @objc private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardsButtonsArray.firstIndex(of: sender) {
            game.choiseCard(at: cardNumber)
            uploadViewFromModel()
            
        } else {
            print("Cant find card index in array")
        }
    }
    
    @objc private func newGameButton(_ sender: UIButton) {
        newGame()
        uploadViewFromModel()
    }
    
    private func newGame() {
        for index in game.cards.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            game.cards[index].flipCountForScore = 0
        }
        emoji = [:]
        guard let newTheme = theme else {return}
        emojiChoise = newTheme
        game.scoreCount = 0
        game.flipCount = 0
    }
    
    
    private func uploadViewFromModel() {
        if cardsButtonsArray != nil {
            scoresLabel.text = "Score: \(game.scoreCount)"
            flipCountsLabel.text = "Flip count: \(game.flipCount)"
            for cardIndex in cardsButtonsArray.indices {
                let card = game.cards[cardIndex]
                let button = cardsButtonsArray[cardIndex]
                if card.isFaceUp {
                    button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    button.setTitle(emoji(for: card), for: .normal)
                } else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : colorMain
                }
            }
        }
        
    }
    
    private var emojiChoise = "♣️♥️♦️♠️💄🦷💋👥🙏🏽👀"
    private var colorMain = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
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
