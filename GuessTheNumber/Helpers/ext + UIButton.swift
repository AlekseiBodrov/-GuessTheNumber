//
//  ext + UIButton.swift
//  GuessTheNumber
//
//  Created by Алексей on 01.11.2022.
//

import Foundation
import UIKit

extension UIButton {
    static func configureButton(_ button: UIButton, label: String){
        button.titleLabel?.text = label
        button.layer.cornerRadius = 15
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
    }
}
