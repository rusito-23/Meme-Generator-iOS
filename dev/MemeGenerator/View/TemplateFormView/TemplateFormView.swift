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
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var selectCustom: UILabel!
    @IBOutlet weak var continueButton: CustomButton!
    private var mainWindow: UIWindow {
        return UIApplication.shared.keyWindow!
    }

    // MARK: Lifecycle
    
    override func customConfig() {
        // Template picker config
        selectTemplate.delegate = self

        // select template picker
        selectTemplate.font = MainFont.paragraph()
        selectTemplate.text = "CHOOSE_YOUR_TEMPLATE".localized()

        // or label
        orLabel.font = MainFont.miniParagraph()
        orLabel.text = "S_OR".localized()

        // select custom label
        selectCustom.font = MainFont.paragraph()
        selectCustom.text = "SELECT_CUSTOM_TEMPLATE".localized()

        // continue button
        continueButton.setTitle("BTN_CONTINUE".localized(), for: .normal)
    }
    
    override func setupWithSuperView(_ superView: UIView) {
        super.setupWithSuperView(superView)
        
        // templates initalization
        presenter?.findTemplates()
        
        // Show animation
        self.frame.origin.x = superView.bounds.origin.x + mainWindow.frame.width
        UIView.animate(withDuration: 1, animations: {
            self.frame.origin.x = superView.bounds.origin.x
        })
    }
    
    func hide() {
        guard let superView = self.superview else { return }
        
        // Hide animation
        self.frame.origin.x = superView.bounds.origin.x
        UIView.animate(withDuration: 1, animations: {
            self.frame.origin.x = superView.bounds.origin.x - self.mainWindow.frame.width
        }, completion: { [weak self] _ in
            self?.removeFromSuperview()
        })
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

// MARK: TextField Delegate

extension TemplateFormView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.showTableView()
    }

}

// MARK: Table View Managment

extension TemplateFormView: UITableViewDelegate, UITableViewDataSource {

    private func showTableView() {
        let tableView = UITableView()
        mainWindow.addSubview(tableView)
        tableView.frame = mainWindow.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.frame.origin.x = self.bounds.origin.x + mainWindow.frame.width
        tableView.register(UINib(nibName: MemeCell.xib, bundle: nil), forCellReuseIdentifier: MemeCell.identifier)
        UIView.animate(withDuration: 0.5, animations: {
            tableView.frame.origin.x = self.bounds.origin.x
        })
    }

    private func hideTableView(tableView: UITableView) {
        UIView.animate(withDuration: 0.5, animations: {
            tableView.frame.origin.x = self.bounds.origin.x + self.mainWindow.frame.width
        }, completion: { _ in
            tableView.removeFromSuperview()
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.templates?.count ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let template = templates?[indexPath.row] else { return }
        selectTemplate.text = template.name
        self.endEditing(true)
        self.presenter?.templateSelected(template)
        self.hideTableView(tableView: tableView)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemeCell.identifier) as! MemeCell
        guard let memeTemplate = templates?[indexPath.row] else {
            return cell
        }
        cell.setup(with: memeTemplate)
        return cell
    }

}
