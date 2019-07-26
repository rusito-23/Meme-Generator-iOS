//
//  HTTPGetMemes.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/26/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation

struct GetMemesResponse: Codable {
    var success: Bool?
    var data: GetMemesResponseData?
}

struct GetMemesResponseData: Codable {
    var memes: [Meme]?
}
