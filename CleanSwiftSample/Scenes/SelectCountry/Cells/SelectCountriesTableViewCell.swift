//
//  SelectCountriesTableViewCell.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation
import UIKit

class SelectCountriesTableViewCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .body1Font
        label.textColor = .contrastedText

        return label
    }()
    
    let paddedLabel: PaddedLabel = {
        let label = PaddedLabel(customPadding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .contrastedBack
        label.backgroundColor = .ocean
        label.font = .body2Font

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // Colors
        self.backgroundColor = .smoke
        self.contentView.backgroundColor = .smoke

        // Subviews
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(paddedLabel)

        // Layout
        self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true

        self.paddedLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.paddedLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        self.paddedLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
        self.paddedLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.paddedLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12).isActive = true
    }
    
    /// Use this method to update cell UI, passing nil will have no affect on current UI element's state
    public func update(title: String?, selected: Bool?) {
        if let strongTitle = title {
            self.titleLabel.text = strongTitle
        }

        if let strongSelectionState = selected {
            let selectionColor: UIColor = strongSelectionState ? .gale : .ocean
            let selectionText = strongSelectionState ?
                LanguageManager.getStringValue(forKey: LanguageManager.added, defaultValue: "Added") :
                LanguageManager.getStringValue(forKey: LanguageManager.add, defaultValue: "Add")
            
            self.paddedLabel.backgroundColor = selectionColor
            self.paddedLabel.text = selectionText
        }
    }
}
