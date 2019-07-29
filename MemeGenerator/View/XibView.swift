//
//  XibView.swift
//  CopyFace
//
//  Created by Igor Andruskiewitsch on 7/16/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//
import Foundation
import UIKit

class XibView: UIView {
    
    // MARK: inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let view = loadNib()
        self.addSubview(view)
        customConfig()
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func customConfig() {
        
    }
    
    func setupWithSuperView(_ superView: UIView) {
        self.autoresizesSubviews = false
        self.clipsToBounds = true
        superView.addSubview(self)
        self.frame = superView.bounds
    }
    
}
