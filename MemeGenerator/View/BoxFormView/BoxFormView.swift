//
//  BoxFormView.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/29/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit

class BoxFormView: XibView {
    
    // MARK: Clean vars
    
    var presenter: FormPresenter?
    var selected: MemeTemplate?
    
    // MARK: Boxes
    
    @IBOutlet weak var boxTables: UITableView!
    var boxes: [String] = []

    // MARK: Lifecycle
    
    override func customConfig() {
        self.boxTables.dataSource = self
        self.boxTables.register(UINib(nibName: "BoxCell", bundle: nil),
                                forCellReuseIdentifier: "BOX_CELL")
    }
    
    override func setupWithSuperView(_ superView: UIView) {
        super.setupWithSuperView(superView)
        
        if let count = selected?.boxCount {
            for i in 0...(count - 1) {
                self.boxes.append(defaultText(for: i))
            }
        }

        self.presenter?.previewTemplate()
    }

}

// MARK: TableView methods

extension BoxFormView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selected?.boxCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BOX_CELL") as? BoxCell else {
            logger.error("Could not dequeue reusable table cell")
            fatalError()
        }
        
        cell.textBoxField?.delegate = self
        cell.textBoxField?.tag = indexPath.row
        cell.textBoxField?.placeholder = defaultText(for: indexPath.row)
        
        return cell
    }
    
}

// MARK: UITextField Delegate methods

extension BoxFormView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        boxes[textField.tag] = textField.text ?? defaultText(for: textField.tag)
        self.presenter?.previewTemplate()
        return true
    }
    
}

// MARK: Helpers

extension BoxFormView {
    
    private func defaultText(for index: Int) -> String {
        return "TextBox -> \(index)"
    }
    
}
