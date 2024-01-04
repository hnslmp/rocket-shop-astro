//
//  AppHelper.swift
//  pokemon-ajaib
//
//  Created by Hansel Matthew on 20/03/23.
//

import UIKit

class AppHelper {
    
    static let shared = AppHelper()
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
        
}
