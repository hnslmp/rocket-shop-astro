//
//  AppHelper.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//

import UIKit

class AppHelper {
    
    static let shared = AppHelper()
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var topSafeAreaHeight: CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return window?.safeAreaInsets.top ?? 0
    }
        
}
