//
//  IOPageViewController.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
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
        
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.hostingController.willMove(toParent: self)
        self.hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(self.hostingController.view)
        
        NSLayoutConstraint.activate([
            self.hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            self.hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            self.hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            self.hostingController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
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
