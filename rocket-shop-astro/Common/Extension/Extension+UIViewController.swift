//
//  Extension+UIViewController.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 07/01/24.
//

import UIKit
import Toast_Swift

extension UIViewController {
    @objc func showError(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.handleError(error: error)
        }
    }
    
    private func handleError(error: Error) {
        self.view.makeToast(error.localizedDescription, duration: 3.0, position: .bottom)
    }
}
