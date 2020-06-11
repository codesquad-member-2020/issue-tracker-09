//
//  UIColor.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

extension UIColor {
    static let mask: Int = 0x000000FF
    static let colorPalette: CGFloat = 255.0
    
    convenience init?(hex: String, alpha: CGFloat = 1) {
        var color: UInt64 = 0
        guard hex.hasPrefix("#") else { return nil }
        let hexColor = String(hex.dropFirst())
        guard hexColor.count == 6 else { return nil }
        let scanner = Scanner(string: hexColor)
        scanner.scanHexInt64(&color)
        let red = CGFloat(Int(color >> 16) & Self.mask) / Self.colorPalette
        let green = CGFloat(Int(color >> 8) & Self.mask) / Self.colorPalette
        let blue = CGFloat(Int(color) & Self.mask) / Self.colorPalette
        
        self.init(red: red,
                  green: green,
                  blue: blue,
                  alpha: alpha)
    }
}
