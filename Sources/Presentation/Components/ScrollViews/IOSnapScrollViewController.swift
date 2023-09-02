//
//  IOSnapScrollViewController.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.02.2023.
//

import Foundation
import IOSwiftUICommon
import SwiftUI
import UIKit

final public class IOSnapScrollViewController<Content: View>: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Defs
    
    public typealias PageChangeHandler = (_ page: Int) -> Void
    
    // MARK: - Properties
    
    private(set) public var hostingController: IOSwiftUIViewController<Content>!
    
    // MARK: - Privates
    
    private let itemWidth: CGFloat
    private let initialPage: Int
    private let clipsToBounds: Bool
    
    private var isInitialPageUpdated: Bool
    private var startingScrollingOffset: CGPoint!
    private var pageChangeHandler: PageChangeHandler?
    private var scrollViewSizeObservation: NSKeyValueObservation?
    
    private weak var scrollView: UIScrollView?
    private weak var widthConstraint: NSLayoutConstraint?
    
    // MARK: - View Lifecycle
    
    public init(
        itemWidth: CGFloat,
        initialPage: Int,
        clipsToBounds: Bool
    ) {
        self.initialPage = initialPage
        self.itemWidth = itemWidth
        self.clipsToBounds = clipsToBounds
        self.isInitialPageUpdated = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.initialPage = 0
        self.itemWidth = 0
        self.clipsToBounds = true
        self.isInitialPageUpdated = false
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
        scrollView.clipsToBounds = self.clipsToBounds
        
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
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        self.scrollViewSizeObservation = self.scrollView!.observe(\.bounds, changeHandler: { [weak self] scrollView, _ in
            guard let self else { return }
            
            let scrollViewWidth = scrollView.bounds.size.width
            if !self.isInitialPageUpdated && scrollViewWidth > 0 {
                let newX = scrollViewWidth * CGFloat(self.initialPage)
                
                if newX >= 0 {
                    self.scrollView?.setContentOffset(CGPoint(x: newX, y: 0), animated: false)
                }
                
                self.isInitialPageUpdated = true
            }
        })
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.scrollViewSizeObservation?.invalidate()
    }
    
    // MARK: - Helper Methods
    
    public func setupHostingController(hostingController: IOSwiftUIViewController<Content>) {
        self.hostingController = hostingController
    }
    
    public func setPage(_ page: Int) {
        if !self.isInitialPageUpdated {
            return
        }
        
        let itemWidth = self.scrollView?.bounds.size.width ?? 0
        let newX = itemWidth * CGFloat(page)
        
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
    
    public func setPageChangeHandler(_ handler: PageChangeHandler?) {
        self.pageChangeHandler = handler
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
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = currentPage(offset: scrollView.contentOffset.x)
        self.pageChangeHandler?(currentPage)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let currentPage = currentPage(offset: scrollView.contentOffset.x)
        self.pageChangeHandler?(currentPage)
    }
    
    // MARK: - Private Helpers
    
    private func currentPage(offset: CGFloat) -> Int {
        let page = abs(offset) / itemWidth
        return Int(page)
    }
}
