// 
//  IODefaultDatePickerView.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.01.2023.
//

import Foundation
import SwiftUI

public struct IODefaultDatePickerView: IODatePickerViewProtocol {
    
    // MARK: - Privates
    
    private let data: IODatePickerData
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let font: IOFontType
    
    @State private var selectedDate: Date
    
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
                        .padding([.top, .bottom], 16)
                        .padding(.trailing, 12)
                    }
                    .background(backgroundColor)
                    .zIndex(8)
                    
                    Color.gray
                        .opacity(0.2)
                        .frame(height: 1)
                        .padding(.top, -4)
                        .zIndex(10)
                    
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
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
    
    public init(data: IODatePickerData) {
        self.data = data
        self.backgroundColor = .white
        self.foregroundColor = .black
        self.font = .systemRegular(14)
        
        if let selectedDate = data.selectedItem {
            self._selectedDate = State<Date>(initialValue: selectedDate)
        } else {
            self._selectedDate = State<Date>(initialValue: Date())
        }
    }
    
    private init(
        data: IODatePickerData,
        backgroundColor: Color,
        foregroundColor: Color,
        font: IOFontType
    ) {
        self.data = data
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
        
        if let selectedDate = data.selectedItem {
            self._selectedDate = State<Date>(initialValue: selectedDate)
        } else {
            self._selectedDate = State<Date>(initialValue: Date())
        }
    }
    
    // MARK: - Modifiers
    
    public func backgroundColor(_ color: Color) -> IODefaultDatePickerView {
        return IODefaultDatePickerView(
            data: data,
            backgroundColor: color,
            foregroundColor: foregroundColor,
            font: font
        )
    }
    
    public func foregroundColor(_ color: Color) -> IODefaultDatePickerView {
        return IODefaultDatePickerView(
            data: data,
            backgroundColor: backgroundColor,
            foregroundColor: color,
            font: font
        )
    }
    
    public func font(type: IOFontType) -> IODefaultDatePickerView {
        return IODefaultDatePickerView(
            data: data,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            font: type
        )
    }
    
    // MARK: - Helper Methods
    
    private func handleDoneButton() {
        data.selectedItemString = selectedDate.string(format: data.dateFormat) ?? ""
        data.selectedItem = selectedDate
        
        data.handler?()
    }
}

#if DEBUG
struct IODefaultDatePickerView_Previews: PreviewProvider {
    
    struct IODefaultDatePickerViewDemo: View {
        
        @State private var selectedDate: Date?
        @State private var selectedDateString = ""
        
        var body: some View {
            IODefaultDatePickerView(
                data: IODatePickerData(
                    doneButtonTitle: .commonDone,
                    dateFormat: "MM dd yyyy",
                    selectedItem: $selectedDate,
                    selectedItemString: $selectedDateString
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return IODefaultDatePickerViewDemo()
    }
}
#endif
