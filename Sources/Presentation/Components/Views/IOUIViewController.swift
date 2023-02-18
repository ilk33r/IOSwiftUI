//
//  IOUIViewController.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import UIKit
import SwiftUI
import IOSwiftUICommon

final public class IOUIViewController<Content: View>: UIViewController {
    
    // MARK: - Defs
    
    public enum Lifecycle {
        case willAppear
        case didAppear
        case willDisappear
        case didDisappear
    }
    
    public typealias LifecycleHandler = (_ lifecycle: Lifecycle) -> Void
    
    // MARK: - Properties
    
    private(set) public var hostingController: IOSwiftUIViewController<Content>!
    
    // MARK: - Privates
    
    private var handler: LifecycleHandler?
    
    // MARK: - View Lifecycle
    
    public init(
        hostingController: IOSwiftUIViewController<Content>,
        handler: LifecycleHandler?
    ) {
        super.init(nibName: nil, bundle: nil)
        
        self.hostingController = hostingController
        self.handler = handler
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        self.hostingController = nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hostingController.add(parent: self, toView: self.view, constraints: IOConstraints.safeAreaAll)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.handler?(.willAppear)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.handler?(.didAppear)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.handler?(.willDisappear)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.handler?(.didDisappear)
    }
}
