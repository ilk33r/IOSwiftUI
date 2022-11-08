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
    
    private let phoneNumberPattern = "+## (###) ### ## ##"
    
    @ObservedObject public var presenter: UpdateProfilePresenter
    @StateObject public var navigationState = UpdateProfileNavigationState()
    
    @State private var showLocationSelection = false
    
    @State private var formUserNameText = ""
    @State private var formEmailText = ""
    @State private var formNameText = ""
    @State private var formSurnameText = ""
    @State private var formBirthDate: Date?
    @State private var formPhone = ""
    @State private var formLocationName = ""
    @State private var formLocationLatitude: Double?
    @State private var formLocationLongitude: Double?
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                IOUIView { lifecycle in
                    if lifecycle == .willAppear {
                        presenter.hideTabBar()
                    } else if lifecycle == .willDisappear {
                        presenter.showTabBar()
                    }
                } content: {
                    ScrollView {
                        IOFormGroup(.commonDone, handler: {
                        }, content: {
                            VStack(alignment: .leading) {
                                FloatingTextField(.updateProfileFormUserName, text: $formUserNameText)
                                    .disabled(true)
                                FloatingTextField(.updateProfileFormEmail, text: $formEmailText)
                                    .disabled(true)
                                FloatingTextField(.updateProfileFormName, text: $formNameText)
                                FloatingTextField(.updateProfileFormSurname, text: $formSurnameText)
                                FloatingDatePicker(.updateProfileFormBirthdate, date: $formBirthDate)
                                FloatingTextField(.updateProfileFormPhone, text: $formPhone)
                                    .keyboardType(.numberPad)
                                FloatingTextField(.updateProfileFormLocation, text: $formLocationName)
                                    .disabled(true)
                                    .setClick {
                                        showLocationSelection = true
                                    }
                            }
                            .padding(.horizontal, 16.0)
                            .padding(.vertical, 8.0)
                        })
                    }
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
        .popover(isPresented: $showLocationSelection, content: {
            IORouterUtilities.route(
                ProfileRouters.self,
                .userLocation(
                    entity: UserLocationEntity(
                        isPresented: $showLocationSelection,
                        locationName: $formLocationName,
                        locationLatitude: $formLocationLatitude,
                        locationLongitude: $formLocationLongitude
                    )
                )
            )
        })
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
            formPhone = output.phone.applyPattern(pattern: phoneNumberPattern)
            formLocationName = output.locationName
            formLocationLatitude = output.locationLatitude
            formLocationLongitude = output.locationLongitude
        }
        .onChange(of: formPhone) { newValue in
            let plainNumber = newValue.trimLetters()
            formPhone = plainNumber.applyPattern(pattern: phoneNumberPattern)
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
