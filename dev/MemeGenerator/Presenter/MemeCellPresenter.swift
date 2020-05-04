//
//  MemeCellPresenter.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 5/4/20.
//  Copyright © 2020 Igor Andruskiewitsch. All rights reserved.
//

import Foundation

class MemeCellPresenter {
    weak var cell: MemeCell?
    var memeService: MemeService?

    init() {
        self.memeService = MemeServiceImpl()
    }

    func preview(template: MemeTemplate?) {
        guard let imageURI = template?.imageURI else {
            return
        }

        self.memeService?.getMemeTemplatePreview(with: imageURI) { [weak self] (image) in
            guard let self = self else { return }
            self.cell?.setImageView(image)
        }
    }

}
