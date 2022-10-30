// 
//  HomePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppPresentation
import SwiftUI

final public class HomePresenter: IOPresenterable {
    
    // MARK: - Defs
    
    struct ActionSheetData: Identifiable {
        
        let id = UUID()
    }
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: HomeInteractor!
    
    // MARK: - Properties
    
    @Published var actionSheetData: ActionSheetData?
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    func showActionSheet() {
        self.actionSheetData = ActionSheetData()
    }
}
