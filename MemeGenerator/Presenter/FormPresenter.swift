//
//  FormPresenter.swift
//  MemeGenerator
//
//  Created by Igor on 27/07/2019.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation

// MARK: Setup

class FormPresenter {
    
    // MARK: Clean
    weak var formController: FormViewController?
    var templateForm: TemplateFormView?
    
    // MARK: Services
    var memeService: MemeService?

    init() {
        self.memeService = MemeServiceImpl()
    }
    
}

// MARK: Form state methods

extension FormPresenter {
    
    func showTemplateForm() {
        self.templateForm = TemplateFormView()
        self.templateForm?.presenter = self
        
        if let formView = self.formController?.formView {
            self.templateForm?.setupWithSuperView(formView)
        }
    }
    
    func templateSelected(_ memeTemplate: MemeTemplate) {
        guard let imageURI =  memeTemplate.imageURI else { return }
        
        DispatchQueue.global(qos: .background) .async { [weak self] in
            guard let `self` = self else { return }
            
            self.memeService?.getMemeTemplatePreview(with: imageURI) { [weak self] (image) in
                guard let `self` = self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    if image != nil {
                        self?.formController?.setTemplatePreview(image!)
                    } else {
                        self?.formController?.templatePreviewError()
                    }
                }
            }
        }
    }

}

// MARK: Service methods

extension FormPresenter {
    
    func findTemplates() {
        DispatchQueue.global(qos: .background).async {
            self.memeService?.getMemeTemplates { [weak self] (response) in
                guard let `self` = self else { return }
                
                guard let res = response,
                    response?.success ?? false,
                    let templates = res.data?.memes else {
                        DispatchQueue.main.async { [weak self] in
                            self?.templateForm?.onTemplatesError()
                        }
                        return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.templateForm?.onTemplatesFound(templates)
                }
            }
        }
    }

}
