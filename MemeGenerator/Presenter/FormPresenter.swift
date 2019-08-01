//
//  FormPresenter.swift
//  MemeGenerator
//
//  Created by Igor on 27/07/2019.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit

// MARK: Setup

class FormPresenter {
    
    // MARK: Clean
    
    weak var formController: FormViewController?
    var templateForm: TemplateFormView?
    var boxesForm: BoxFormView?
    
    // MARK: Vars
    
    var selected: MemeTemplate?

    // MARK: Services
    
    var memeService: MemeService?

    init() {
        self.memeService = MemeServiceImpl()
    }
    
}

// MARK: Form state methods

extension FormPresenter {
    
    func onBack() {
        if self.templateForm != nil {
            self.formController?.dismiss(animated: true, completion: nil)
        } else if self.boxesForm != nil {
            hideBoxesForm()
            showTemplateForm()
        }
    }
    
    func showTemplateForm() {
        
        hideBoxesForm()
        
        self.templateForm = TemplateFormView()
        self.templateForm?.presenter = self
        
        if let formView = self.formController?.formView {
            self.templateForm?.setupWithSuperView(formView)
        }
    }
    
    func hideTemplatesForm() {
        self.templateForm?.removeFromSuperview()
        self.templateForm = nil
    }
    
    func showBlocksForm() {
        
        guard let selectedTemplate = self.selected else {
            self.formController?.showError(with: "Sorry! No image was selected")
            return
        }
        
        hideTemplatesForm()

        self.boxesForm = BoxFormView()
        self.boxesForm?.selected = selectedTemplate
        self.boxesForm?.presenter = self
        
        if let formView = self.formController?.formView {
            self.boxesForm?.setupWithSuperView(formView)
        }
    }
    
    func hideBoxesForm() {
        self.boxesForm?.removeFromSuperview()
        self.boxesForm = nil
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyBoardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let form = formController else { return }
        let keyBoardFrame = keyBoardSize.cgRectValue
        
        if form.view.frame.origin.y == 0 {
            form.view.frame.origin.y -= keyBoardFrame.height
        }
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        guard let form = formController else { return }
        if form.view.frame.origin.y != 0 {
            form.view.frame.origin.y = 0
        }
    }
    
}

// MARK: Service methods

extension FormPresenter {
    
    /*
     Send list of available templates to the the templateForm completion,
     to be listed in the view.
     */
    func findTemplates() {
        self.formController?.showLoading()
        DispatchQueue.global(qos: .background).async {
            self.memeService?.getMemeTemplates { [weak self] (response) in
                guard let `self` = self else { return }
                
                guard let res = response,
                    response?.success ?? false,
                    let templates = res.data?.memes else {
                        DispatchQueue.main.async { [weak self] in
                            self?.formController?.hideLoading()
                            // TODO: check internet connection
                            self?.formController?.showError(with: "No templates were found!")
                        }
                        return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.formController?.hideLoading()
                    self?.templateForm?.onTemplatesFound(templates)
                }
            }
        }
    }
    
    /*
     When a template is selected, this methods loads the image
     to preview the meme in the templateForm.
     */
    func templateSelected(_ memeTemplate: MemeTemplate) {
        
        self.selected = memeTemplate
        
        guard let imageURI =  memeTemplate.imageURI else { return }
        
        self.formController?.previewImage.showLoading()
        DispatchQueue.global(qos: .background) .async { [weak self] in
            guard let `self` = self else { return }
            
            self.memeService?.getMemeTemplatePreview(with: imageURI) { [weak self] (image) in
                guard let `self` = self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.formController?.previewImage.hideLoading()
                    if image != nil {
                        self?.formController?.setTemplatePreview(image!)
                    } else {
                        // TODO: check internet connection
                        self?.formController?.showError(with: "Template couldn't be loaded!")
                    }
                }
            }
        }
    }
    
    
    /*
     Preview the meme, with every text block added by the user,
     before even saving the image.
     */
    func previewTemplate() {
        
        guard let templateId = self.selected?.id,
            let boxes = boxesForm?.boxes else {
            // TODO: Show warning?
            return
        }
        
        let request = CaptionImageRequest(templateId: templateId, boxes: boxes)

        self.formController?.previewImage.showLoading()
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self else { return }

            self.memeService?.getMemeCaption(request) { [weak self] (image) in
                guard let `self` = self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.formController?.previewImage.hideLoading()
                    if image != nil {
                        self?.formController?.setTemplatePreview(image!)
                    } else {
                        // TODO: check internet connection
                        self?.formController?.showError(with: "Template could not be preview!")
                    }
                }
            }
        }
    }
    

}
