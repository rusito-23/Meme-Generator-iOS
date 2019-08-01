//
//  UIView.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 8/1/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func showLoading() {
        let loadingView = LoadingView()
        loadingView.setupWithSuperView(self)
    }
    
    func hideLoading() {
        for view in self.subviews {
            if view.isKind(of: LoadingView.self) {
                view.removeFromSuperview()
            }
        }
    }
    
}
