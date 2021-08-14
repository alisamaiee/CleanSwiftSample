//
//  PaddedLabel.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation
import UIKit

class PaddedLabel: UILabel {
    
    var inset: CGSize = CGSize(width: 4, height: 12)
    var frameHeight: CGFloat = 0
    private let customPadding: UIEdgeInsets
    
    init(customPadding: UIEdgeInsets = UIEdgeInsets.zero) {
        self.customPadding = customPadding
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var padding: UIEdgeInsets {
        var hasText:Bool = false
        if let t = self.text?.count, t > 0 {
            hasText = true
        } else if let t = attributedText?.length, t > 0 {
            hasText = true
        }
        
        return hasText ? UIEdgeInsets(top: inset.height + customPadding.top, left: inset.width + customPadding.left, bottom: inset.height + customPadding.bottom, right: inset.width + customPadding.right) : .zero
    }
    
    override func layoutSubviews() {
        self.frameHeight = self.frame.size.height
        super.layoutSubviews()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
        self.layer.cornerRadius = self.frameHeight / 2
        self.layer.masksToBounds = true
    }
    
    override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let p = padding
        let width = superContentSize.width + p.left + p.right
        let heigth = superContentSize.height + p.top + p.bottom
        return CGSize(width: width, height: heigth)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let p = padding
        let width = superSizeThatFits.width + p.left + p.right
        let heigth = superSizeThatFits.height + p.top + p.bottom
        return CGSize(width: width, height: heigth)
    }
}
