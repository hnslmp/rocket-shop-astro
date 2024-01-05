//
//  Extension+UIView.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//

import UIKit
import SwifterSwift
import SkeletonView

extension UIView {
    
    func startSkeleton() {
        isSkeletonable = true
        showAnimatedGradientSkeleton()
        startSkeletonAnimation()
    }
    
    func stopSkeleton() {
        guard isSkeletonable, sk.isSkeletonActive else { return }
        DispatchQueue.main.async { [weak self] in
            self?.stopSkeletonAnimation()
            self?.hideSkeleton()
        }
    }
    
}

