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
        self.hide()
    }

    // MARK: Setup
    
    override func setupWithSuperView(_ superView: UIView) {
        self.autoresizesSubviews = false
        self.clipsToBounds = true
        self.frame = mainWindow.frame
        mainWindow.addSubview(self)
        show(on: superView)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        self.backgroundColor = .white
        self.errorMessageLabel.font = MainFont.title()
    }

    // MARK: Show hide animations

    private var mainWindow: UIWindow {
        return UIApplication.shared.keyWindow!
    }

    private func show(on superView: UIView) {
        self.frame.origin.x = superView.bounds.origin.x + mainWindow.frame.width
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.origin.x = superView.bounds.origin.x
        })
    }

    private func hide() {
        guard let superview = superview else { return }
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.frame.origin.x = superview.bounds.origin.x + self.mainWindow.frame.width
        }, completion: { [weak self] _ in
            self?.removeFromSuperview()
        })
    }
    
}
