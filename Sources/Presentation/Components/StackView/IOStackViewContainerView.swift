//
//  IOStackViewContainerView.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import UIKit

final public class IOStackViewContainerView<TView: UIView>: UIView {
    
    // MARK: - Properties

    public private(set) weak var contentView: TView!
    
    public var rowInsets: UIEdgeInsets! {
        get {
            return self.layoutMargins
        }
        set {
            self.layoutMargins = newValue
        }
    }

    // MARK: - Initialization Methods
    
    public required init(contentView: TView) {
        super.init(frame: CGRect.zero)
        self.setupViews(contentView: contentView)
        self.setupConstraints()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI

    private func setupViews(contentView: TView) {
        // Setup view
        self.clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.rowInsets = UIEdgeInsets.zero
        
        // Setup layout margins
        contentView.insetsLayoutMarginsFromSafeArea = false
        
        // Add content view to hierarchy
        self.addSubview(contentView)
        self.contentView = contentView
    }
    
    private func setupConstraints() {
        // Create view constraints
        let bottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        bottomConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
        
        let constraints = [
            self.contentView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            bottomConstraint
        ]
        
        // Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}
