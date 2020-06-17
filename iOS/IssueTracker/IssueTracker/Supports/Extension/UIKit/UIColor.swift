//
//  UIColor.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor? {
        colors.randomElement() ?? UIColor()
    }
    static private var colors: [UIColor?] {
        let colors = [ UIColor(hex: "#222831"),
                       UIColor(hex: "#393e46"),
                       UIColor(hex: "#00adb5"),
                       UIColor(hex: "#eeeeee"),
                       UIColor(hex: "#f9ed69"),
                       UIColor(hex: "#f08a5d"),
                       UIColor(hex: "#b83b5e"),
                       UIColor(hex: "#6a2c70"),
                       UIColor(hex: "#f38181"),
                       UIColor(hex: "#fce38a"),
                       UIColor(hex: "#eaffd0"),
                       UIColor(hex: "#222831"),
                       UIColor(hex: "#a8d8ea"),
                       UIColor(hex: "#aa96da"),
                       UIColor(hex: "#fcbad3"),
                       UIColor(hex: "#ffffd2"),
                       UIColor(hex: "#ffb6b6"),
                       UIColor(hex: "#fde2e2"),
                       UIColor(hex: "#aacfcf"),
                       UIColor(hex: "#679b9b"),
                       UIColor(hex: "#142850"),
                       UIColor(hex: "#27496d"),
                       UIColor(hex: "#00909e"),
                       UIColor(hex: "#dae1e7"),
                       UIColor(hex: "#ffe8df"),
                       UIColor(hex: "#f0f0f0"),
                       UIColor(hex: "#888888"),
                       UIColor(hex: "#363062"),
                       UIColor(hex: "#4d4c7d"),
                       UIColor(hex: "#827397"),
                       UIColor(hex: "#d8b9c3")]
        
        return colors
    }
    var hexString: String {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        getRed(&red,
               green: &green,
               blue: &blue,
               alpha: &alpha)
        
        return String(format: "#%02X%02X%02X",
                     (Int)(red * UIColor.colorPalette),
                     (Int)(green * UIColor.colorPalette),
                     (Int)(blue * UIColor.colorPalette))
    }
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
