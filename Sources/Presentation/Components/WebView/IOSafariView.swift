//
//  IOSafariView.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.02.2023.
//

import Foundation
import SwiftUI
import SafariServices

public struct IOSafariView: UIViewControllerRepresentable {

    // MARK: - Defs
    
    public typealias UIViewControllerType = SFSafariViewController
    
    // MARK: - Privates

    private let url: URL
    
    // MARK: - Initialization Methods
    
    public init(
        url: URL
    ) {
        self.url = url
    }

    public func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}
