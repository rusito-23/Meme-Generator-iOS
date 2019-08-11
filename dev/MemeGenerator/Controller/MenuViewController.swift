//
//  MenuViewController.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 7/25/19.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import UIKit
import Photos

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if accessNeedRequests() {
            requestAccess()
        }
    }


}

// MARK: UI Functions

extension MenuViewController {
    
    @IBAction func onGetStartedClicked(_ sender: Any) {
        if accessNeedRequests() {
            self.createAccessAlert()
        } else {
            logger.info("All accesses granted!")
            self.performSegue(withIdentifier: SegueConstants.SHOW_FORM, sender: self)
        }
    }
    
    func createAccessAlert() {
        let alert = UIAlertController(title: "ACCESS_ALERT_TITLE".localized(),
                                      message: "ACCESS_ALERT_MSG".localized(),
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "BTN_OK".localized(),
                                      style: .default,
                                      handler: { [weak self] action in
                                        guard let `self` = self else { return }
                                        self.requestAccess()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: Access request functions

extension MenuViewController {
    
    func requestAccess() {
        PHPhotoLibrary.requestAuthorization({_ in})
    }
    
    func accessNeedRequests() -> Bool {
        return photoNeedsRequests()
    }
    
    func photoNeedsRequests() -> Bool {
        let photos = PHPhotoLibrary.authorizationStatus()
        return photos == .denied || photos == .notDetermined
    }
    
}

