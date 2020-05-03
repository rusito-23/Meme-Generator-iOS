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

    // MARK: Properties and Outlets

    @IBInspectable
    var message: String? {
        set { errorMessageLabel.text = newValue }
        get { return errorMessageLabel.text }
    }
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        guard let superView = superview else { return }
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.frame.origin.x = superView.bounds.origin.x + self.mainWindow.frame.width
        }, completion: { [weak self] _ in
            self?.removeFromSuperview()
        })
    }

    // MARK: Setup

    private var mainWindow: UIWindow {
        return UIApplication.shared.keyWindow!
    }
    
    override func setupWithSuperView(_ superView: UIView) {
        self.autoresizesSubviews = false
        self.clipsToBounds = true
        self.frame = mainWindow.frame
        mainWindow.addSubview(self)
        self.frame.origin.x = superView.bounds.origin.x + mainWindow.frame.width
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.origin.x = superView.bounds.origin.x
        })
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        self.backgroundColor = .white
        self.errorMessageLabel.font = MainFont.title()
    }
    
}
