// 
//  UpdateProfileView.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared
import SwiftUISampleAppPresentation

public struct UpdateProfileView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = UpdateProfilePresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: UpdateProfilePresenter
    @StateObject public var navigationState = UpdateProfileNavigationState()
    
    @State private var formUserNameText = ""
    @State private var formNameText = ""
    @State private var formSurnameText = ""
    @State private var formBirthDate: Date?
    
    @EnvironmentObject private var appEnvironment: IOAppEnvironmentObject
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                ScrollView {
                    IOFormGroup(.commonDone, handler: {
                    }, content: {
                        VStack(alignment: .leading) {
                            FloatingTextField(.updateProfileFormUserName, text: $formUserNameText)
                                .disabled(true)
                            FloatingTextField(.updateProfileFormName, text: $formNameText)
                            FloatingTextField(.updateProfileFormSurname, text: $formSurnameText)
                            FloatingDatePicker(.updateProfileFormBirthdate, date: $formBirthDate)
                        }
                        .padding(.horizontal, 16.0)
                        .padding(.vertical, 8.0)
                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .updateProfileTitle,
                    iconName: "person.fill"
                )
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .controllerWireframe {
            UpdateProfileNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
                presenter.load()
            }
        }
        .onReceive(presenter.$uiModel) { output in
            guard let output else { return }
            
            formUserNameText = output.userName
            formNameText = output.name
            formSurnameText = output.surname
            formBirthDate = output.birthDate
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView(
            entity: UpdateProfileEntity(
                member: MemberModel()
            )
        )
    }
}
