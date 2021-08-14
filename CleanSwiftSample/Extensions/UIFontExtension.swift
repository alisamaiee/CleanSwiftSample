//
//  UIFontExtension.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/9/21.
//

import Foundation
import UIKit

internal extension UIFont {
    static let heading1Font =  UIFont.systemFont(ofSize: 24, weight: .medium)
    static let heading2Font =  UIFont.systemFont(ofSize: 19, weight: .semibold)
    static let title1Font =    UIFont.systemFont(ofSize: 19, weight: .regular)
    static let title2Font =    UIFont.systemFont(ofSize: 17, weight: .medium)
    static let body1Font =     UIFont.systemFont(ofSize: 17, weight: .regular)
    static var body2Font =     UIFont.systemFont(ofSize: 15, weight: .regular)
    static var body3Font =     UIFont.systemFont(ofSize: 15, weight: .medium)
    static let buttonFont =    UIFont.systemFont(ofSize: 17, weight: .medium)
    static let caption1Font =  UIFont.systemFont(ofSize: 15, weight: .light)
    static let caption2Font =  UIFont.systemFont(ofSize: 12, weight: .semibold)
    static let caption3Font =  UIFont.systemFont(ofSize: 12, weight: .regular)
    static let overline1Font = UIFont.systemFont(ofSize: 8, weight: .bold)
    static let labelFont =     UIFont.systemFont(ofSize: 8, weight: .light)
    static let scriptFont =    UIFont(name: "CourierNewPSMT", size: 15)
}
