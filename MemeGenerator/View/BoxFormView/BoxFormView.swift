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
    
    var boxes: [String] = []
    
    // MARK: Outlets
    
    @IBOutlet weak var boxTables: UITableView!
    
    // MARK: Lifecycle
    
    override func customConfig() {
        self.boxTables.dataSource = self
        self.boxTables.register(UINib(nibName: "BoxCell", bundle: nil),
                                forCellReuseIdentifier: "BOX_CELL")
    }
    
    override func setupWithSuperView(_ superView: UIView) {
        super.setupWithSuperView(superView)
        
        for i in 0...(selected?.boxCount ?? 0) {
            self.boxes.append("box: \(i)")
        }
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
        
        cell.boxLabel?.text = self.boxes[indexPath.row]
        
        return cell
    }
    
}
