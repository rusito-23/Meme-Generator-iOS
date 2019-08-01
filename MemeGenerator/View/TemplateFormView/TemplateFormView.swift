//
//  TemplateFormView.swift
//  MemeGenerator
//
//  Created by Igor on 28/07/2019.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class TemplateFormView: XibView {
    
    // MARK: Clean variables
    
    var presenter: FormPresenter?
    var templates: [MemeTemplate]?
    
    // MARK: IBOutlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var templateSelected: UITextField!
    
    // MARK: Lifecycle
    
    override func customConfig() {
        // template picker config
        let pickerView = UIPickerView()
        templateSelected.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func setupWithSuperView(_ superView: UIView) {
        super.setupWithSuperView(superView)
        
        // templates initalization
        presenter?.findTemplates()
    }
    
    @IBAction func onContinue(_ sender: Any) {
        self.presenter?.showBlocksForm()
    }
    
}

// MARK: Presenter comunication

extension TemplateFormView {
    
    func onTemplatesFound(_ templates: [MemeTemplate]) {
        logger.info("Templates set!")
        self.templates = templates
    }
    
}

// MARK: Presenter comunication

extension TemplateFormView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.templates?.count ?? 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return templates?[row].name ?? "empty"
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let template = templates?[row] else { return }
        
        templateSelected.text = template.name
        self.endEditing(true)
        
        self.presenter?.templateSelected(template)
    }

}
