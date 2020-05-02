//
//  FormViewController.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/25/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit


class FormViewController: UIViewController {
    
    // MARK: Clean variables
    var presenter: FormPresenter?
    
    // MARK: IBOutlets
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpView()

        // presenter config
        self.presenter = FormPresenter()
        self.presenter?.formController = self
        self.presenter?.showTemplateForm()
    }
}

// MARK: UI Functions

extension FormViewController {

    func setUpView() {
        self.titleLabel.text = "FORM_TITLE".localized();
        self.titleLabel.font = MainFont.subtitle()
    }

    func createShareAlert() {
        let alert = UIAlertController(title: "SHARE_ALERT_TITLE".localized(),
                                      message: "SHARE_ALERT_MSG".localized(),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "BTN_YEA".localized(),
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: Navigation bar control

extension FormViewController {
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.presenter?.onBack()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let finalImage = self.previewImage.image else {
            logger.warning("No image to share!")
            createShareAlert()
            return
        }
        let shareVC = UIActivityViewController(activityItems: [finalImage], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        self.present(shareVC, animated: true, completion: nil)
    }
    
}

// MARK: Template preview

extension FormViewController {
    func setTemplatePreview(_ image: UIImage) {
        self.previewImage.image = image
    }
}
