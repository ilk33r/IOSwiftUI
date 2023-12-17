//
//  IOPageViewController.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUICommon
import SwiftUI
import UIKit

final public class IOPageViewController: UIViewController {
    
    // MARK: - Defs
    
    typealias PageChangeHandler = (_ page: Int) -> Void
    
    // MARK: - Properties
    
    private(set) public var hostingController: IOSwiftUIViewController<AnyView>!
    
    // MARK: - Privates
    
    private let initialPage: Int
    
    private var isInitialPageUpdated: Bool
    private var pageChangeHandler: PageChangeHandler?
    private var scrollViewSizeObservation: NSKeyValueObservation?
    
    private weak var scrollView: UIScrollView?
    private weak var widthConstraint: NSLayoutConstraint?
    
    // MARK: - View Lifecycle
    
    public init(
        initialPage: Int,
        hostingController: IOSwiftUIViewController<AnyView>
    ) {
        self.initialPage = initialPage
        self.isInitialPageUpdated = false
        super.init(nibName: nil, bundle: nil)
        
        self.hostingController = hostingController
    }
    
    required init?(coder: NSCoder) {
        self.initialPage = 0
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
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        self.hostingController.add(parent: self, toView: scrollView, constraints: IOConstraints.all)
        self.hostingController.view.addEqualHeight(scrollView.heightAnchor)
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
