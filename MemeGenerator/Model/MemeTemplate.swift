//
//  Template.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/26/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation

struct MemeTemplate: Codable {
    
    // MARK: Variables
    var id: String?
    var name: String?
    var imageURI: String?
    var width: Int?
    var height: Int?
    var boxCount: Int?
    
    // MARK: Keys
    private enum CodingKeys : String, CodingKey {
        case id, name, imageURI = "url", width, height, boxCount = "box_count"
    }
}
