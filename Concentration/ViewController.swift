//
//  ViewController.swift
//  Concentration
//
//  Created by Takasur Azeem on 14/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var game: Concentration!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipsCountLabel: UILabel!
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    var numberOfPairOfCards: Int {
        (cardButtons.count + 1) / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
        updateViewFromModel()
    }

    func updateViewFromModel() {
        flipsCountLabel.text = "Flips: \(game.flipsCount)"
        flipsCountLabel.textColor = game.selectedTheme.primaryColor
        
        gameScoreLabel.text = "Score: \(game.score)"
        gameScoreLabel.textColor =  game.selectedTheme.primaryColor
        
        
        for cardIndex in cardButtons.indices {
            let card = game.cards[cardIndex]
            let button = cardButtons[cardIndex]
            if card.isFaceUp {
                button.setTitle(game.emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : game.selectedTheme.primaryColor
            }
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        let index = cardButtons.firstIndex(of: sender)!
        game.chooseCard(at: index)
        updateViewFromModel()
    }
    
    @IBAction func newGameButtonTapped(_ sender: UIBarButtonItem) {
        game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
        updateViewFromModel()
    }
}

