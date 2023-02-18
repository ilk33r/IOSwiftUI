//
//  IOPageViewController.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUICommon
import UIKit
import SwiftUI

final public class IOPageViewController: UIViewController {
    
    // MARK: - Defs
    
    typealias PageChangeHandler = (_ page: Int) -> Void
    
    // MARK: - Properties
    
    private(set) public var hostingController: IOSwiftUIViewController<AnyView>!
    
    // MARK: - Privates
    
    private var pageChangeHandler: PageChangeHandler?
    
    private weak var scrollView: UIScrollView?
    private weak var widthConstraint: NSLayoutConstraint?
    
    // MARK: - View Lifecycle
    
    public init(
        hostingController: IOSwiftUIViewController<AnyView>
    ) {
        super.init(nibName: nil, bundle: nil)
        
        self.hostingController = hostingController
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        self.hostingController = nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView(
            containerView: self.view,
            constraints: IOConstraints.safeAreaAll
        )
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        self.hostingController.add(parent: self, toView: scrollView, constraints: IOConstraints.all)
        self.hostingController.view.addEqualHeight(scrollView.heightAnchor)
        self.scrollView = scrollView
        self.scrollView?.delegate = self
    }
    
    // MARK: - Helper Methods
    
    func setHandler(_ handler: PageChangeHandler?) {
        self.pageChangeHandler = handler
    }
    
    public func setPage(_ page: Int) {
        let itemWidth = self.scrollView?.bounds.size.width ?? 0
        let newX = (itemWidth * CGFloat(page)) - itemWidth
        
        if newX >= 0 {
            self.scrollView?.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
        }
    }
    
    public func updateWidth(_ width: CGFloat) {
        if self.widthConstraint == nil {
            self.widthConstraint = self.hostingController.view.addWidth(width)
        } else {
            self.widthConstraint?.constant = width
        }
    }
}

extension IOPageViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewWidth = self.scrollView?.frame.size.width ?? 0
        let pageNumberDouble = ceil(scrollView.contentOffset.x / viewWidth)
        self.pageChangeHandler?(Int(pageNumberDouble))
    }
}
