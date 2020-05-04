//
//  MemeCell.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 5/4/20.
//  Copyright © 2020 Igor Andruskiewitsch. All rights reserved.
//

import UIKit

class MemeCell: UITableViewCell {
    static let xib = "MemeCell"
    static let identifier = "MemeCellIdentifier"
    private var presenter:MemeCellPresenter?

    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.presenter = MemeCellPresenter()
        self.presenter?.cell = self

        self.descriptionLabel.font = MainFont.paragraph()
        self.previewImage.contentMode = .scaleAspectFit
        self.descriptionLabel.text = "MEME_NO_TITLE".localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(with meme:MemeTemplate) {
        self.previewImage.image = nil
        self.previewImage.showLoading()
        self.descriptionLabel.text = meme.name
        self.presenter?.preview(template: meme)
    }

    func setImageView(_ image: UIImage?) {
        self.previewImage.hideLoading()
        self.previewImage.image = image
        self.previewImage.setNeedsDisplay()
    }
    
}
