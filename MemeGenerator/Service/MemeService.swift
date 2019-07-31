//
//  MemeService.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/26/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

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
    
    func getMemeTemplatePreview(with urlString: String, _ completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else {
                completion(nil)
                return
            }
            completion(image)
        }
    }

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
    
    func getMemeCaption(_ request: CaptionImageRequest, _ completion: @escaping (UIImage?) -> Void) {
        
        guard var url = URL(string: captionURL)?
            .appending("username", value: request.username)
            .appending("password", value: request.password)
            .appending("template_id", value: request.templateId),
            let boxesEnum = request.boxes?.enumerated() else {
            return
        }

        for (index, box) in boxesEnum {
            url = url.appending("boxes[\(index)][text]", value: box)
        }
        
        Alamofire.request(url)
            .responseData { [weak self] (response) in
                guard let `self` = self else { return }
                
                guard response.error == nil,
                    let data = response.data else {
                        logger.error("Request gave error/no data")
                        completion(nil)
                        return
                }
                
                guard let res = try? self.jsonDecoder.decode(CaptionImageResponse.self, from: data),
                    res.success ?? false,
                    let imageURIString = res.data?.url,
                    let imageURI = URL(string: imageURIString) else {
                        
                    logger.error("Response not successfull!")
                    completion(nil)
                    return
                }
                
                Alamofire.request(imageURI)
                    .responseImage { response in
                        guard let image = response.result.value else {
                            completion(nil)
                            return
                        }
                        completion(image)
                }
        }
    }

}
