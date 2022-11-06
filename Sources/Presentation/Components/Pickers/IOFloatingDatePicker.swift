//
//  IOFloatingDatePicker.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure

public struct IOFloatingDatePicker<PickerOverlay: View>: View {
    
    // MARK: - Privates
    
    @Binding private var date: Date?
    
    @State private var selectedDate = Date()
    @State private var selectInitialDate = false
    
    private let dateFormater: DateFormatter
    private let localizationType: IOLocalizationType
    
    private var backgroundColor: Color
    private var fontType: IOFontType
    private var foregroundColor: Color
    private var pickerOverlay: PickerOverlay
    private var placeholderColor: Color
    private var placeholderPaddingActive: EdgeInsets
    private var placeholderPaddingDefault: EdgeInsets
    
    private var placeholderPadding: EdgeInsets {
        if shouldPlaceHolderMove {
            return placeholderPaddingActive
        }
        
        return placeholderPaddingDefault
    }
    
    private var shouldPlaceHolderMove: Bool {
        date != nil
    }
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                IOPopoverView(
                    show: $selectInitialDate,
                    size: CGSize(width: proxy.size.width - 16, height: 320),
                    content: {
                        pickerOverlay
                            .setClick {
                                selectInitialDate.toggle()
                            }
                    },
                    popoverContent: {
                        DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .background(backgroundColor)
                            .foregroundColor(placeholderColor)
                            .labelsHidden()
                            .font(type: fontType)
                            .padding()
                            .accentColor(placeholderColor)
                            .zIndex(1)
                    }
                )
                Text(localizationType.localized)
                    .font(type: fontType)
                    .foregroundColor(placeholderColor)
                    .background(backgroundColor)
                    .allowsHitTesting(false)
                    .zIndex(2)
                    .padding(placeholderPadding)
                if let date {
                    Text(dateFormater.string(from: date))
                        .font(type: fontType)
                        .foregroundColor(foregroundColor)
                        .background(backgroundColor)
                        .allowsHitTesting(false)
                        .zIndex(3)
                        .padding()
                }
            }
            .onChange(of: selectedDate) { newValue in
                date = newValue
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ l: IOLocalizationType,
        date: Binding<Date?>,
        dateFormat: String,
        @ViewBuilder pickerOverlay: () -> PickerOverlay
    ) {
        self.dateFormater = DateFormatter()
        self.dateFormater.dateFormat = dateFormat
        
        self._date = date
        self.foregroundColor = Color.black
        self.localizationType = l
        self.pickerOverlay = pickerOverlay()
        self.placeholderColor = Color.gray
        self.fontType = .systemRegular(16)
        self.backgroundColor = Color.white
        self.placeholderPaddingActive = EdgeInsets(top: 0, leading: 12, bottom: 52, trailing: 0)
        self.placeholderPaddingDefault = EdgeInsets(top: 0, leading: 17, bottom: 0, trailing: 0)
        
        if let initialDate = self.date {
            self.selectedDate = initialDate
        }
    }
    
    private init(
        _ l: IOLocalizationType,
        date: Binding<Date?>,
        dateFormat: String,
        pickerOverlay: PickerOverlay,
        foregroundColor: Color,
        placeholderColor: Color,
        fontType: IOFontType,
        backgroundColor: Color,
        placeholderPaddingActive: EdgeInsets,
        placeholderPaddingDefault: EdgeInsets
    ) {
        self.dateFormater = DateFormatter()
        self.dateFormater.dateFormat = dateFormat
        
        self.localizationType = l
        self._date = date
        self.pickerOverlay = pickerOverlay
        self.foregroundColor = foregroundColor
        self.placeholderColor = placeholderColor
        self.fontType = fontType
        self.backgroundColor = backgroundColor
        self.placeholderPaddingActive = placeholderPaddingActive
        self.placeholderPaddingDefault = placeholderPaddingDefault
        
        if let initialDate = self.date {
            self.selectedDate = initialDate
        }
    }
    
    public func activePlaceholderPadding(_ padding: EdgeInsets) -> IOFloatingDatePicker<PickerOverlay> {
        return IOFloatingDatePicker(
            localizationType,
            date: $date,
            dateFormat: dateFormater.dateFormat,
            pickerOverlay: pickerOverlay,
            foregroundColor: foregroundColor,
            placeholderColor: placeholderColor,
            fontType: fontType,
            backgroundColor: backgroundColor,
            placeholderPaddingActive: padding,
            placeholderPaddingDefault: placeholderPaddingDefault
        )
    }
    
    public func backgroundColor(_ color: Color) -> IOFloatingDatePicker<PickerOverlay> {
        return IOFloatingDatePicker(
            localizationType,
            date: $date,
            dateFormat: dateFormater.dateFormat,
            pickerOverlay: pickerOverlay,
            foregroundColor: foregroundColor,
            placeholderColor: placeholderColor,
            fontType: fontType,
            backgroundColor: color,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault
        )
    }
    
    public func font(type: IOFontType) -> IOFloatingDatePicker<PickerOverlay> {
        return IOFloatingDatePicker(
            localizationType,
            date: $date,
            dateFormat: dateFormater.dateFormat,
            pickerOverlay: pickerOverlay,
            foregroundColor: foregroundColor,
            placeholderColor: placeholderColor,
            fontType: type,
            backgroundColor: backgroundColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault
        )
    }
    
    public func placeholderColor(_ color: Color) -> IOFloatingDatePicker<PickerOverlay> {
        return IOFloatingDatePicker(
            localizationType,
            date: $date,
            dateFormat: dateFormater.dateFormat,
            pickerOverlay: pickerOverlay,
            foregroundColor: foregroundColor,
            placeholderColor: color,
            fontType: fontType,
            backgroundColor: backgroundColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault
        )
    }
    
    public func placeholderPadding(_ padding: EdgeInsets) -> IOFloatingDatePicker<PickerOverlay> {
        return IOFloatingDatePicker(
            localizationType,
            date: $date,
            dateFormat: dateFormater.dateFormat,
            pickerOverlay: pickerOverlay,
            foregroundColor: foregroundColor,
            placeholderColor: placeholderColor,
            fontType: fontType,
            backgroundColor: backgroundColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: padding
        )
    }
    
    public func textColor(_ color: Color) -> IOFloatingDatePicker<PickerOverlay> {
        return IOFloatingDatePicker(
            localizationType,
            date: $date,
            dateFormat: dateFormater.dateFormat,
            pickerOverlay: pickerOverlay,
            foregroundColor: color,
            placeholderColor: placeholderColor,
            fontType: fontType,
            backgroundColor: backgroundColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault
        )
    }
}

struct IODatePicker_Previews: PreviewProvider {
    
    struct IODatePickerDemo: View {
    
        @State var birthDate: Date?
        
        var body: some View {
            IOFloatingDatePicker(
                .init(rawValue: "Birthdate"),
                date: $birthDate,
                dateFormat: "dd MM yyyy",
                pickerOverlay: {
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.black, lineWidth: 2)
                        .frame(height: 52)
                }
            )
            .padding(20)
            .frame(height: 60)
        }
    }
    
    static var previews: some View {
        IODatePickerDemo()
    }
}
