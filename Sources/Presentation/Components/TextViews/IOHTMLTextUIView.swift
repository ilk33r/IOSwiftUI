//
//  IOHTMLTextUIView.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.01.2023.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import UIKit

public class IOHTMLTextUIView: UITextView {
    
    // MARK: - Defs
    
    public typealias LinkClickHandler = (_ link: URL) -> Void
    
    // MARK: - Theming
    
    public var lineHeight: CGFloat? {
        didSet {
            self.applyStringAttributes()
        }
    }
    
    @objc dynamic public var boldFont: UIFont? {
        didSet {
            self.applyStringAttributes()
        }
    }
    
    @objc dynamic public var linkColor: UIColor? {
        didSet {
            self.applyStringAttributes()
        }
    }
    
    @objc dynamic public var htmlText: String? {
        didSet {
            self.applyStringAttributes()
        }
    }
    
    // MARK: - Privates
    
    private var clickHandler: LinkClickHandler?
    
    // MARK: - Initialization Methods
    
    public init(_ clickHandler: LinkClickHandler?) {
        super.init(frame: .zero, textContainer: nil)
        self.clickHandler = clickHandler
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - View Lifecycle
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview == nil {
            self.delegate = nil
        } else {
            self.delegate = self
        }
    }
    
    // MARK: - Helper Methods
    
    public func applyStringAttributes() {
        guard let htmlText = self.htmlText else { return }
        if self.boldFont == nil {
            return
        }
        
        if let linkColor = self.linkColor {
            self.linkTextAttributes = [ .foregroundColor: linkColor ]
        }
        
        // Parse html tags
        var plainString = ""
        let attributedStringParts = IOAttributedStringUtilities.createAttributes(fromHtmlString: htmlText, plainString: &plainString)
        
        // Create paragraph style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        if let lineHeight = self.lineHeight {
            paragraphStyle.lineSpacing = lineHeight
        }
        
        // Create an attributed string
        let attributedString = NSMutableAttributedString(
            string: plainString,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )
        attributedString.addAttribute(.foregroundColor, value: self.textColor ?? UIColor.black, range: NSRange(location: 0, length: plainString.count))
        
        // Loop throught attributes
        for attribute in attributedStringParts {
            if attribute.type == .bold {
                attributedString.addAttribute(NSAttributedString.Key.font, value: self.boldFont!, range: attribute.range)
            } else if attribute.type == .link {
                attributedString.addAttribute(NSAttributedString.Key.link, value: attribute.urlString ?? "", range: attribute.range)
            }
        }
        
        // Update attributed string
        self.attributedText = attributedString
    }
}

extension IOHTMLTextUIView: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        IOLogger.debug("Text clicked: \(URL.absoluteString)")
        self.clickHandler?(URL)
        return true
    }
}
