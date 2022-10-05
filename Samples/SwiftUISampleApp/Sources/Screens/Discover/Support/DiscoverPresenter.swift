// 
//  DiscoverPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppPresentation
import SwiftUI

final class DiscoverPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Environment = SampleAppEnvironment
    typealias Interactor = DiscoverInteractor
    
    var environment: EnvironmentObject<SampleAppEnvironment>!
    var interactor: DiscoverInteractor!
    
    // MARK: - Constants
    
    private let itemPerPage = 20
    
    // MARK: - Initialization Methods
    
    init() {
    }
    
    // MARK: - Presenter
    
    func loadValues(start: Int) {
        self.interactor.discover(start: start, count: self.itemPerPage)
    }
}
