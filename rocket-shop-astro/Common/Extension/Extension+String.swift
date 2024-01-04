//
//  Extension+String.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//
import UIKit
import SwifterSwift

extension String {
    
    func convertToHex() -> UIColor {
        guard let color = UIColor.init(hexString: self) else { return UIColor.clear }
        return color
    }
}
