//
//  FSEmptyStateView.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 1.10.2021.
//

import UIKit

// This View will be shown when app can't get any venue
class FSEmptyStateView: UIView {

    private let messageLabel = FSLabel(textAlignment: .center, fontSize: Sizes.emptyStateMessageFontSize, textColor: .secondaryLabel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configure() {
        addSubViews(messageLabel)
        configureMessageLabel()
    }
    
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 3

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

}

