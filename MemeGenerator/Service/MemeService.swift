//
//  MemeService.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/26/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import Alamofire

// MARK: Base class

class MemeServiceImpl {
    
    // MARK: Variables
    
    private let memesURL = "https://api.imgflip.com/get_memes"
    private let captionURL = "https://api.imgflip.com/caption_image"
    
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    
}

// MARK: Protocol Implementation

extension MemeServiceImpl: MemeService {

    func getMemeTemplates(_ completion: @escaping (GetMemesResponse?) -> Void) {
        
        guard let url = URL(string: memesURL) else {
            return
        }
        
        Alamofire.request(url)
            .responseData { [weak self] (response: DataResponse<Data>) in
                guard let `self` = self else { return }
                
                guard response.error == nil,
                    let data = response.data else {
                        logger.error("Request gave error/no data")
                        completion(nil)
                        return
                }
                
                do {
                    logger.info("Request successfull")
                    completion(try self.jsonDecoder.decode(GetMemesResponse.self, from: data))
                } catch {
                    logger.info("Parse error")
                    completion(nil)
                }
        }
        
    }
    
    func getMemeCaption(_ request: CaptionImageRequest, _ completion: @escaping (CaptionImageResponse?) -> Void) {
    }
    
}
