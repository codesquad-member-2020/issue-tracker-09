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
    
    var hexString: String {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        getRed(&red,
               green: &green,
               blue: &blue,
               alpha: &alpha)
        let rgb = (Int)(red * Self.colorPalette) << 16 | (Int)(green * Self.colorPalette) << 8 | Int(blue * Self.colorPalette)
        
        return String(format: "#%06X", rgb)
    }
    
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
    
    static var random: UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        let color = self.init(red: randomRed,
                              green: randomGreen,
                              blue: randomBlue,
                              alpha: 1.0)
        
        return color
    }
}
