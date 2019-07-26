//
//  HTTPBodies.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/26/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation

// MARK: Request

struct CaptionImageRequest: Codable {
    
    // MARK: Variables
    var templateId: String?
    var username: String?
    var password: String?
    var text0: String?
    var text1: String?
    
    // MARK: Keys
    private enum CodingKeys : String, CodingKey {
        case templateId = "template_id",
            username,
            password,
            text0,
            text1
    }

}

// MARK: Response

struct CaptionImageResponse: Codable {
    
    // MARK: Variables
    var success: Bool?
    var data: CaptionImageResponseData?

}

struct CaptionImageResponseData: Codable {
    
    // MARK: Variables
    var url: String?
    var pageUrl: String?
    
    // MARK: Keys
    private enum CodingKeys : String, CodingKey {
        case url, pageUrl = "page_url"
    }
}
