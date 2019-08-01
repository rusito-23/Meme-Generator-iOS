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
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // presenter config
        self.presenter = FormPresenter()
        self.presenter?.formController = self
        self.presenter?.showTemplateForm()
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
            return
        }
        
        let shareVC = UIActivityViewController(activityItems: [finalImage] , applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        self.present(shareVC, animated: true, completion: nil)
    }
    
}


extension FormViewController {
    
    func setTemplatePreview(_ image: UIImage) {
        self.previewImage.image = image
    }
    
}
