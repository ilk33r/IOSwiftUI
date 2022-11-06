//
//  IOPopoverWrapperViewController.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import SwiftUI
import UIKit

final public class IOPopoverWrapperViewController<Content: View>: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK: - Properties
    
    private(set) public var hostingController: UIHostingController<AnyView>!
    
    // MARK: - Privates
    
    private let content: (() -> Content)!
    private let onDismiss: (() -> Void)!
    
    private var size: CGSize?
    
    private weak var popoverVC: UIViewController?
    
    // MARK: - View Lifecycle
    
    public init() {
        self.content = nil
        self.onDismiss = nil
        self.size = nil
        self.hostingController = nil
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(size: CGSize?, content: @escaping () -> Content, onDismiss: @escaping () -> Void) {
        self.content = content
        self.onDismiss = onDismiss
        self.size = size
        self.hostingController = nil
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.content = nil
        self.onDismiss = nil
        self.size = nil
        self.hostingController = nil
        
        super.init(coder: coder)
    }
    
    deinit {
        self.size = nil
        self.hostingController = nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helper Methods
    
    public func showPopover() {
        guard popoverVC == nil else { return }
        
        let vc = UIHostingController(rootView: self.content())
        
        if let size = self.size {
            vc.preferredContentSize = size
        }
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        
        if let popover = vc.popoverPresentationController {
            popover.sourceView = view
            popover.delegate = self
        }
        
        self.popoverVC = vc
        self.present(vc, animated: true, completion: nil)
    }
    
    public func hidePopover() {
        guard let vc = popoverVC, !vc.isBeingDismissed else { return }
        vc.dismiss(animated: true, completion: nil)
        self.popoverVC = nil
    }
    
    public func updateSize(_ size: CGSize?) {
        self.size = size
        
        if let vc = self.popoverVC, let size = size {
            vc.preferredContentSize = size
        }
    }
    
    // MARK: - Popover Delegate
    
    public func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        self.popoverVC = nil
        self.onDismiss()
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
