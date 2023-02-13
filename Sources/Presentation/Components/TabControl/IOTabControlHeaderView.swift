//
//  IOTabControlHeaderView.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import UIKit
import IOSwiftUIInfrastructure

final public class IOTabControlHeaderView: UIView {
    
    // MARK: - Defs
    
    public typealias ClickHandler = (_ index: Int) -> Void
    
    // MARK: - Publics
    
    var movePercent: CGFloat? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var selectedIndex: Int! {
        didSet {
            self.updateSelectedButton()
        }
    }
    
    // MARK: - Theming
    
    @objc dynamic public var lineColor: UIColor? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @objc dynamic public var lineHeight: NSNumber? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - Privates
    
    private var buttons: [IOTabControlButton?]!
    private var clickHandler: ClickHandler?
    private weak var stackView: IOStackView?
    
    // MARK: - Row Methods
    
    public func configure(
        titles: [String],
        textColor: UIColor,
        font: UIFont,
        handler: ClickHandler?
    ) {
        self.backgroundColor = .white
        self.addHeight(28)
        self.movePercent = nil
        self.selectedIndex = 0
        self.buttons = []
        self.clickHandler = handler
        
        if self.stackView == nil {
            let stackView = IOStackView(containerView: self, constraints: [.top(0), .trailing(0), .leading(0), .bottom(-2)])
            stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            self.stackView = stackView
        }
        
        self.stackView?.removeAllViews()
        for (index, buttonTitle) in titles.enumerated() {
            self.stackView?.addRow(type: IOTabControlButton.self) { [weak self] container in
                container?.contentView.setTitle(buttonTitle, for: .normal)
                container?.contentView.setTitle(buttonTitle, for: .highlighted)
                container?.contentView.setTitleColor(textColor, for: .normal)
                container?.contentView.setTitleColor(textColor, for: .highlighted)
                container?.contentView.titleLabel?.font = font
                container?.contentView.tag = index
                container?.contentView.addTarget(self, action: #selector(IOTabControlHeaderView.btnTabTapped(_:)), for: .touchUpInside)
                
                self?.buttons.append(container?.contentView)
            }
        }
        
        self.updateSelectedButton()
    }
    
    // MARK: - Drawing
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard self.selectedIndex != nil else { return }
        guard self.buttons != nil else { return }
        guard let lineColor = self.lineColor else { return }
        guard let lineHeight = self.lineHeight else { return }
        
        if self.buttons.isEmpty { return }
        
        let context = UIGraphicsGetCurrentContext()
        
        let lineWidth = rect.size.width / CGFloat(self.buttons.count)
        var lineStartX = CGFloat(self.selectedIndex) * lineWidth
        
        if let movePercent = self.movePercent {
            lineStartX = lineWidth * movePercent
        }
        
        let line = UIBezierPath(rect: CGRect(x: lineStartX, y: rect.size.height - 2, width: lineWidth, height: CGFloat(lineHeight.floatValue)))
        context?.setFillColor(lineColor.cgColor)
        line.fill()
    }
    
    // MARK: - Actions
    
    @objc dynamic private func btnTabTapped(_ sender: IOTabControlButton!) {
        self.clickHandler?(sender.tag)
    }
    
    // MARK: - Helper Methods
    
    private func updateSelectedButton() {
        guard self.buttons != nil else { return }
        
        for (index, button) in self.buttons.enumerated() {
            if index == self.selectedIndex {
                button?.isHighlighted = true
            } else {
                button?.isHighlighted = false
            }
        }
        
        self.movePercent = nil
        self.setNeedsDisplay()
    }
}
