//
//  String.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 8/1/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
