// 
//  IODefaultPickerView.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.01.2023.
//

import Foundation
import SwiftUI

public struct IODefaultPickerView: IOPickerViewProtocol {
    
    // MARK: - Privates
    
    private let data: IOPickerData
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let font: IOFontType
    private let pickerItems: [String]
    
    @State private var selectedValue: String
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                VStack {
                    HStack {
                        Spacer()
                        Button(data.doneButtonTitle) {
                            handleDoneButton()
                        }
                        .padding([.top, .bottom], 12)
                        .padding(.trailing, 12)
                    }
                    .background(backgroundColor)
                    .zIndex(8)
                    
                    Color.gray
                        .opacity(0.2)
                        .frame(height: 1)
                        .padding(.top, -4)
                        .zIndex(10)
                    
                    Picker(
                        "",
                        selection: $selectedValue
                    ) {
                        ForEach(pickerItems, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.wheel)
                    .background(backgroundColor)
                    .foregroundColor(foregroundColor)
                    .labelsHidden()
                    .font(type: font)
                    .accentColor(foregroundColor)
                    .padding(.bottom, -12)
                    .padding(.top, -16)
                    .zIndex(4)
                    
                    backgroundColor
                        .frame(height: proxy.safeAreaInsets.bottom)
                }
            }
            .frame(
                width: proxy.size.width,
                height: proxy.size.height + proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom,
                alignment: .bottom
            )
            .ignoresSafeArea()
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(data: IOPickerData) {
        self.data = data
        self.backgroundColor = .white
        self.foregroundColor = .black
        self.font = .systemRegular(14)
        self.pickerItems = data.pickerData.map({ $0.displayName })
        
        if let selectedValue = data.selectedItem {
            self._selectedValue = State<String>(initialValue: selectedValue.displayName)
        } else {
            self._selectedValue = State<String>(initialValue: "")
        }
    }
    
    private init(
        data: IOPickerData,
        backgroundColor: Color,
        foregroundColor: Color,
        font: IOFontType
    ) {
        self.data = data
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
        self.pickerItems = data.pickerData.map({ $0.displayName })
        
        if let selectedValue = data.selectedItem {
            self._selectedValue = State<String>(initialValue: selectedValue.displayName)
        } else {
            self._selectedValue = State<String>(initialValue: "")
        }
    }
    
    // MARK: - Modifiers
    
    public func backgroundColor(_ color: Color) -> IODefaultPickerView {
        Self(
            data: data,
            backgroundColor: color,
            foregroundColor: foregroundColor,
            font: font
        )
    }
    
    public func foregroundColor(_ color: Color) -> IODefaultPickerView {
        Self(
            data: data,
            backgroundColor: backgroundColor,
            foregroundColor: color,
            font: font
        )
    }
    
    public func font(type: IOFontType) -> IODefaultPickerView {
        Self(
            data: data,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            font: type
        )
    }
    
    // MARK: - Helper Methods
    
    private func handleDoneButton() {
        if selectedValue.isEmpty {
            data.selectedItem = data.pickerData.first
        } else {
            data.selectedItem = data.pickerData.first(where: { $0.displayName == selectedValue })
        }
        
        data.handler?()
    }
}

#if DEBUG
struct IODefaultPickerView_Previews: PreviewProvider {
    
    struct IODefaultPickerViewDemo: View {
        
        @State var selectedItem: IOPickerUIModel?

        var body: some View {
            IODefaultPickerView(
                data: IOPickerData(
                    doneButtonTitle: .commonDone,
                    data: IODefaultPickerViewPreviewData.previewData,
                    selectedItem: $selectedItem
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return IODefaultPickerViewDemo()
    }
}
#endif
