//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Bogdan Mishura on 8/14/19.
//  Copyright © 2019 Bogdan Mishura. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    let themes = [ "Animals": "👻🎃🥶😱👹😈🤡👽💀👾",
                  "Faces": "😃🤪😎🤩🤓😏🤣😇🥺🥳",
                  "Sports": "⚽️🏀🏈🥍🥎🏓🏐🏉🥏🎱"]
    

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "Choose theme" {
        if let themeName = (sender as? UIButton)?.currentTitle,
            let theme = themes[themeName] {
            if let cvc = segue.destination as? ConcentrationViewController {
                cvc.theme = theme
            }
        
        }
    }
    }
  

}
