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



