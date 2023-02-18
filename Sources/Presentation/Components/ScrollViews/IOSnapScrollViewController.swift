//
//  IOSnapScrollViewController.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.02.2023.
//

import Foundation
import SwiftUI
import UIKit
import IOSwiftUICommon

final public class IOSnapScrollViewController<Content: View>: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    private(set) public var hostingController: IOSwiftUIViewController<Content>!
    
    // MARK: - Privates
    
    private var itemWidth: CGFloat
    private var startingScrollingOffset: CGPoint!
    
    private weak var scrollView: UIScrollView?
    private weak var widthConstraint: NSLayoutConstraint?
    
    // MARK: - View Lifecycle
    
    public init(
        itemWidth: CGFloat
    ) {
        self.itemWidth = itemWidth
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.itemWidth = 0
        super.init(coder: coder)
    }
    
    deinit {
        self.hostingController = nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView(
            containerView: self.view,
            constraints: IOConstraints.all
        )
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        self.hostingController.add(
            parent: self,
            toView: scrollView,
            constraints: IOConstraints.all
        )
        self.hostingController.view.addEqualHeight(scrollView.heightAnchor)
        self.hostingController.view.backgroundColor = .clear
        
        self.scrollView = scrollView
        self.scrollView?.delegate = self
    }
    
    // MARK: - Helper Methods
    
    public func setupHostingController(hostingController: IOSwiftUIViewController<Content>) {
        self.hostingController = hostingController
    }
    
    public func updateWidth(_ width: CGFloat) {
        if self.widthConstraint == nil {
            self.widthConstraint = self.hostingController.view.addWidth(width)
        } else {
            self.widthConstraint?.constant = width
        }
    }
    
    // MARK: - ScrollView Delegate
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.startingScrollingOffset = scrollView.contentOffset
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offset = scrollView.contentOffset.x + scrollView.contentInset.left
        let proposedPage = offset / max(1, self.itemWidth)
        let snapPoint: CGFloat = 0.1
        let snapDelta: CGFloat = offset > self.startingScrollingOffset.x ? (1 - snapPoint) : snapPoint
        var page: CGFloat = 0

        if floor(proposedPage + snapDelta) == floor(proposedPage) {
            page = floor(proposedPage)
        } else {
            page = floor(proposedPage + 1)
        }
        
        targetContentOffset.pointee = CGPoint(
            x: self.itemWidth * page,
            y: targetContentOffset.pointee.y
        )
    }
}
