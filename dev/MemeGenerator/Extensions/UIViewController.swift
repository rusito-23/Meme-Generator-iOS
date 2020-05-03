//
//  ViewController+LoadingView.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/26/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    // MARK: Loading
    
    func showLoading() {
        self.view.showLoading()
    }
    
    func hideLoading() {
        self.view.hideLoading()
    }
    
    // MARK: Error
    
    func showError(with message: String) {
        let errorView = ErrorView()
        errorView.message = message
        errorView.setupWithSuperView(self.view)
    }
    
    // MARK: Orientation
    
    var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        get { return .portrait }
    }
    
}
