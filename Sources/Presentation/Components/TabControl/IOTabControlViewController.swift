//
//  IOTabControlViewController.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import UIKit
import SwiftUI
import IOSwiftUICommon

final public class IOTabControlViewController: UIViewController {
    
    // MARK: - Properties
    
    private(set) public var hostingController: UIHostingController<AnyView>!
    
    // MARK: - Privates

    private let tabControlHeight: CGFloat
    private let tabTitles: [String]
    
    private weak var scrollView: UIScrollView?
    private weak var tabControlHeaderView: IOTabControlHeaderView?
    
    // MARK: - View Lifecycle
    
    public init(
        tabControlHeight: CGFloat,
        tabTitles: [String]
    ) {
        self.tabControlHeight = tabControlHeight
        self.tabTitles = tabTitles
        
        super.init(nibName: nil, bundle: nil)
        
        self.hostingController = UIHostingController(rootView: AnyView(EmptyView()))
    }
    
    required init?(coder: NSCoder) {
        self.tabControlHeight = 52
        self.tabTitles = []
        
        super.init(coder: coder)
    }
    
    deinit {
        self.hostingController = nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = IOStackView(
            containerView: self.view,
            constraints: IOConstraints.safeAreaAll
        )
        
        stackView.addRow(type: IOTabControlHeaderView.self) { [weak self] container in
            guard let self else { return }
            
            container?.contentView.addHeight(self.tabControlHeight)
            container?.contentView.configure(titles: self.tabTitles, handler: { [weak self] index in
                self?.setPage(index + 1)
            })
            
            self.tabControlHeaderView = container?.contentView
        }
        
        stackView.addRow(type: UIScrollView.self) { [weak self] container in
            guard let self else { return }
            
            container?.contentView.isPagingEnabled = true
            container?.contentView.showsVerticalScrollIndicator = false
            container?.contentView.showsHorizontalScrollIndicator = false
            container?.contentView.delegate = self
            
            self.hostingController.willMove(toParent: self)
            container?.contentView.addSubview(view: self.hostingController.view, constraints: IOConstraints.all)
            self.hostingController.view.addEqualHeight(container!.contentView.heightAnchor)
            self.hostingController.didMove(toParent: self)
            self.scrollView = container?.contentView
        }
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

extension IOTabControlViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewWidth = scrollView.bounds.size.width
        let currentOffset = scrollView.contentOffset.x
        let movePercent = currentOffset / scrollViewWidth
        self.tabControlHeaderView?.movePercent = movePercent
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageChanged(scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.pageChanged(scrollView)
    }
    
    private func currentPageIndex(_ scrollView: UIScrollView) -> Int {
        let scrollViewWidth = scrollView.bounds.size.width
        return Int(scrollView.contentOffset.x / scrollViewWidth)
    }
    
    private func pageChanged(_ scrollView: UIScrollView) {
        let currentPageIndex = self.currentPageIndex(scrollView)
        self.tabControlHeaderView?.selectedIndex = currentPageIndex
    }
}
