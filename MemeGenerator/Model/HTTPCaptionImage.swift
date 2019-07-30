//
//  HTTPBodies.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/26/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation

// MARK: Request

struct CaptionImageRequest {
    
    // MARK: Variables
    var templateId: String?
    var boxes: [String]?
    var username: String? {
        get {
            guard let path = Bundle.main.path(forResource: "APICredentials", ofType: "plist") else {
                logger.error("APICredentials.plist required!")
                fatalError()
            }
            
            let dict = NSDictionary(contentsOfFile: path)
            return dict?["username"] as? String
        }
    }
    var password: String? {
        get {
            guard let path = Bundle.main.path(forResource: "APICredentials", ofType: "plist") else {
                logger.error("APICredentials.plist required!")
                fatalError()
            }
            
            let dict = NSDictionary(contentsOfFile: path)
            return dict?["pass"] as? String
        }
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
        case url
        case pageUrl = "page_url"
    }
}
