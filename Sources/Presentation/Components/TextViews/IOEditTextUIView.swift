//
//  IOEditTextUIView.swift
//  
//
//  Created by Adnan ilker Ozcan on 26.01.2023.
//

import Foundation
import UIKit
import IOSwiftUICommon
import IOSwiftUIInfrastructure

final public class IOEditTextUIView: UITextView {
    
    // MARK: - Defs
    
    public typealias ChangeHandler = (_ text: String) -> Void
    
    // MARK: - Privates
    
    private var changeHandler: ChangeHandler?
    
    // MARK: - Initialization Methods
    
    public init(changeHandler: ChangeHandler?) {
        super.init(frame: .zero, textContainer: nil)
        self.changeHandler = changeHandler
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - View Lifecycle
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        
        if self.superview != nil {
            self.isEditable = true
            self.autocorrectionType = .no
            
            self.observeEditingChangedEvents()
        }
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview == nil {
            // Remove all editing events
            self.removeAllEditingEvents()
        }
    }
    
    // MARK: -  Observers
    
    @objc dynamic public func editingChanged(_ textField: IOEditTextUIView) {
        // Call handler
        self.changeHandler?(textField.text ?? "")
    }
    
    @objc dynamic public func editingChangedNotification(_ notification: Notification) {
        if !self.isEqual(notification.object) {
            return
        }
        
        self.editingChanged(notification.object as! IOEditTextUIView)
    }
    
    public func observeEditingChangedEvents() {
        // Obtain notification
        let notificationCenter = NotificationCenter.default
        
        // Remove editing begin event
        notificationCenter.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
        
        // Bind observer
        notificationCenter.addObserver(
            self,
            selector: #selector(IOEditTextUIView.editingChangedNotification(_:)),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
    }
    
    public func removeAllEditingEvents() {
        // Obtain notification
        let notificationCenter = NotificationCenter.default
        
        // Remove all editing events
        notificationCenter.removeObserver(self)
    }
}
