// 
//  StoriesView.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.07.2023.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct StoriesView: IOController {
    
    struct StoryItem: Identifiable {
        
        let name: String
        let back: Color
        
        var id = UUID()
    }
    
    var previewItems = [
        StoryItem(name: "Lorem", back: .gray),
        StoryItem(name: "Ipsum", back: .red),
        StoryItem(name: "Dolor", back: .green),
        StoryItem(name: "Sit", back: .blue),
        StoryItem(name: "Amet", back: .gray),
        StoryItem(name: "consectetur", back: .red),
        StoryItem(name: "adipiscing", back: .yellow)
    ]
    
    // MARK: - Generics
    
    public typealias Presenter = StoriesPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: StoriesPresenter
    @StateObject public var navigationState = StoriesNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                
                IOStoryScrollView(items: previewItems) { item in
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(item.back)
                        Text(item.name)
                    }
                }
                
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                EmptyView()
            }
        }
        .navigationWireframe(hasNavigationView: false) {
            StoriesNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct StoriesView_Previews: PreviewProvider {
    
    struct StoriesViewDemo: View {
        
        var body: some View {
            StoriesView(
                entity: StoriesEntity()
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return StoriesViewDemo()
    }
}
#endif
