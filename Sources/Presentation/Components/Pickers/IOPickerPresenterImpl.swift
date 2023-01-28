//
//  IOPickerPresenterImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.01.2023.
//

import Foundation
import SwiftUI
import UIKit

final public class IOPickerPresenterImpl<Picker: IOPickerViewProtocol, DatePicker: IODatePickerViewProtocol>: IOPickerPresenter {
    
    // MARK: - Privates

    private var pickerView: (_ data: IOPickerData) -> Picker
    private var datePickerView: (_ data: IODatePickerData) -> DatePicker
    private var pickerWindow: IOPresenterWindow?

    // MARK: - New Instance

    public init(
        @ViewBuilder pickerView: @escaping (_ data: IOPickerData) -> Picker,
        @ViewBuilder datePickerView: @escaping (_ data: IODatePickerData) -> DatePicker
    ) {
        self.pickerView = pickerView
        self.datePickerView = datePickerView
    }

    // MARK: - Presentation Methods

    public func show(handler: @escaping IOPickerData.DataHandler) {
        if self.pickerWindow != nil {
            return
        }

        let connectedScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        self.pickerWindow = IOPresenterWindow(frame: UIScreen.main.bounds)
        self.pickerWindow?.windowLevel = .normal
        self.pickerWindow?.backgroundColor = .clear

        var data = handler()
        data.handler = { [weak self] in
            self?.dismiss()
        }
        let pickerVC = UIHostingController(rootView: self.pickerView(data))
        pickerVC.modalPresentationStyle = .overFullScreen
        pickerVC.modalTransitionStyle = .crossDissolve
        pickerVC.view.backgroundColor = .clear
        
        self.pickerWindow?.rootViewController = pickerVC
        self.pickerWindow?.windowScene = connectedScene
        self.pickerWindow?.makeKeyAndVisible()
    }
    
    public func show(handler: @escaping IODatePickerData.DataHandler) {
        if self.pickerWindow != nil {
            return
        }

        let connectedScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        self.pickerWindow = IOPresenterWindow(frame: UIScreen.main.bounds)
        self.pickerWindow?.windowLevel = .normal
        self.pickerWindow?.backgroundColor = .clear

        var data = handler()
        data.handler = { [weak self] in
            self?.dismiss()
        }
        let pickerVC = UIHostingController(rootView: self.datePickerView(data))
        pickerVC.modalPresentationStyle = .overFullScreen
        pickerVC.modalTransitionStyle = .crossDissolve
        pickerVC.view.backgroundColor = .clear
        
        self.pickerWindow?.rootViewController = pickerVC
        self.pickerWindow?.windowScene = connectedScene
        self.pickerWindow?.makeKeyAndVisible()
    }

    public func dismiss() {
        let pickerVC = self.pickerWindow?.rootViewController as? UIHostingController<Picker> ?? self.pickerWindow?.rootViewController as? UIHostingController<DatePicker>
        pickerVC?.dismiss(animated: true, completion: nil)

        self.pickerWindow?.resignKey()
        self.pickerWindow = nil
    }
}
