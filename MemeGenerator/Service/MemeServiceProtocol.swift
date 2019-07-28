//
//  MemeServiceProtocol.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/26/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit

protocol MemeService {
    func getMemeTemplates(_ completion: @escaping (GetMemesResponse?) -> Void)
    func getMemeTemplatePreview(with urlString: String, _ completion: @escaping (UIImage?) -> Void)
    func getMemeCaption(_ request: CaptionImageRequest, _ completion: @escaping (CaptionImageResponse?) -> Void)
}
