//
//  IOStackView.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import UIKit

open class IOStackView: UIStackView {
    
    // MARK: - Properties
    
    open var defaultRowInsets: UIEdgeInsets!
    
    // MARK: - Initialization Methods

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }

    private func initialize() {
        self.defaultRowInsets = UIEdgeInsets.zero
        self.axis = .vertical
        self.contentMode = .top
        self.distribution = .fill
    }
    
    // MARK: - Stack view methods

    @discardableResult
    open func addRow<TView: UIView>(
        type: TView.Type,
        configuration: ((_ container: IOStackViewContainerView<TView>?) -> Void)?
    ) -> IOStackViewContainerView<TView>! {
        let view = type.init(frame: .zero)
        let container = self.addView(view: view)
        configuration?(container)
        return container
    }
    
    open func getRow<TView: UIView>(index: Int, type: TView.Type) -> IOStackViewContainerView<TView>? {
        if self.arrangedSubviews.count > index {
            return self.arrangedSubviews[index] as? IOStackViewContainerView<TView>
        }
        return nil
    }

    // MARK: - Helper methods

    private func addView<TView: UIView>(view: TView) -> IOStackViewContainerView<TView>! {
        // Update view frame
        view.frame = CGRect.zero
        
        // Create content view
        let contentView = IOStackViewContainerView(contentView: view)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Check default row insets defined
        contentView.rowInsets = self.defaultRowInsets
        
        // Add view to arranged subviews
        self.addArrangedSubview(contentView)
        return contentView
    }
    
    open func removeAllViews() {
        for subView in self.arrangedSubviews {
            self.removeArrangedSubview(subView)
            subView.removeFromSuperview()
        }
    }
}
