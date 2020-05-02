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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createButton: CustomButton!
    @IBOutlet weak var logoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        if accessNeedRequests() {
            requestAccess()
        }
    }
}

// MARK: UI Functions

extension MenuViewController {

    func setUpView() {
        self.titleLabel.text = "MENU_TITLE".localized()
        self.titleLabel.font = MainFont.title();
        self.logoImageView.image = UIImage(named: "hide_the_pain")
        self.createButton.setTitle("BTN_CREATE".localized(), for: .normal)
    }
    
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
                                        self?.requestAccess()
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

