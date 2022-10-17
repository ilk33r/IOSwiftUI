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
    
    // MARK: - Properties
    
    private(set) public var hostingController: UIHostingController<AnyView>!
    
    // MARK: - Privates
    
    private weak var scrollView: UIScrollView?
    
    // MARK: - View Lifecycle
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        self.hostingController = UIHostingController(rootView: AnyView(EmptyView()))
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
        
        self.hostingController.willMove(toParent: self)
        scrollView.addSubview(
            view: self.hostingController.view,
            constraints: IOConstraints.all
        )
        self.hostingController.view.addEqualHeight(scrollView.heightAnchor)
        self.hostingController.didMove(toParent: self)
        self.scrollView = scrollView
    }
    
    // MARK: - Helper Methods
    
    public func setPage(_ page: Int) {
        let itemWidth = self.scrollView?.bounds.size.width ?? 0
        let newX = (itemWidth * CGFloat(page)) - itemWidth
        
        if newX >= 0 {
            self.scrollView?.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
        }
    }
    
}
