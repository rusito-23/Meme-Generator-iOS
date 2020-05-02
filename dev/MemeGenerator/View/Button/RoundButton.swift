//
//  CustomButton.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 5/2/20.
//  Copyright © 2020 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class CustomButton: UIButton {

    override init(frame: CGRect) {
     super.init(frame: frame)
     setup()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }

    func setup() {
        self.titleLabel?.font = MainFont.button();
        self.layer.cornerRadius = 10;
        self.backgroundColor = .gray
        self.tintColor = .white;
    }

}
