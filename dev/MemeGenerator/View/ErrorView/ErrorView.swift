//
//  ErrorView.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 8/1/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class ErrorView: XibView {
    
    var parentController: UIViewController?

    @IBInspectable
    var message: String? {
        set { errorMessageV.text = newValue }
        get { return errorMessageV.text }
    }
    
    @IBOutlet weak var errorMessageV: UILabel!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.parentController?.dismiss(animated: true, completion: nil)
        self.removeFromSuperview()
    }
    
    override func setupWithSuperView(_ superView: UIView) {
        let mainWindow = UIApplication.shared.keyWindow!
        
        self.autoresizesSubviews = false
        self.clipsToBounds = true
        self.frame = mainWindow.frame
        
        mainWindow.addSubview(self);
    }
    
}
