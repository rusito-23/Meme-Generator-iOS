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
    
    func showLoading() {
        let loadingView = LoadingView()
        loadingView.setupWithSuperView(self.view)
    }
    
    func hideLoading() {
        for view in self.view.subviews {
            if view.isKind(of: LoadingView.self) {
                view.removeFromSuperview()
            }
        }
    }
    
}
