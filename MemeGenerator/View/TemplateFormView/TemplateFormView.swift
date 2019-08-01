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
    @IBOutlet weak var selectTemplate: UITextField!
    @IBOutlet weak var selectCustom: UILabel!
    
    // MARK: Lifecycle
    
    override func customConfig() {
        // template picker config
        let pickerView = UIPickerView()
        selectTemplate.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // add beta text to selectCustom
//        selectCustom.text += String.withStr
    }
    
    override func setupWithSuperView(_ superView: UIView) {
        super.setupWithSuperView(superView)
        
        // templates initalization
        presenter?.findTemplates()
        
        // Show animation
        let mainWindow = UIApplication.shared.keyWindow!
        self.frame.origin.x = superView.bounds.origin.x + mainWindow.frame.width
        UIView.animate(withDuration: 1, animations: {
            self.frame.origin.x = superView.bounds.origin.x
        })
    }
    
    func hide() {
        guard let superView = self.superview else { return }
        
        // Hide animation
        let mainWindow = UIApplication.shared.keyWindow!
        self.frame.origin.x = superView.bounds.origin.x
        UIView.animate(withDuration: 1, animations: {
            self.frame.origin.x = superView.bounds.origin.x - mainWindow.frame.width
        })
        
        self.removeFromSuperview()
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
        
        selectTemplate.text = template.name
        self.endEditing(true)
        
        self.presenter?.templateSelected(template)
    }

}
