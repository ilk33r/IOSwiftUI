//
//  IOFloatingPicker.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.01.2023.
//

import SwiftUI
import IOSwiftUIInfrastructure

public struct IOFloatingPicker<PickerOverlay: View, Value>: View {
    
    // MARK: - Defs
    
    public typealias UIModel = IOPickerUIModel<Value>
    
    // MARK: - Privates
    
    @Binding private var value: UIModel?
    @Binding private var items: [UIModel]
    
    @State private var selectedValue: String = ""
    @State private var showPicker = false
    @State private var pickerItems: [String] = []
    @State private var popoverHidden = true
    
    private let localizationType: IOLocalizationType
    private let backgroundColor: Color
    private let fontType: IOFontType
    private let foregroundColor: Color
    private let pickerOverlay: PickerOverlay
    private let placeholderColor: Color
    private let placeholderPaddingActive: EdgeInsets
    private let placeholderPaddingDefault: EdgeInsets
    
    private var placeholderPadding: EdgeInsets {
        if shouldPlaceHolderMove {
            return placeholderPaddingActive
        }
        
        return placeholderPaddingDefault
    }
    
    private var shouldPlaceHolderMove: Bool {
        value != nil
    }
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                if !popoverHidden {
                    IOPopoverView(
                        show: $showPicker,
                        size: CGSize(width: proxy.size.width - 16, height: 240),
                        content: {
                            pickerOverlay
                                .setClick {
                                    showPicker.toggle()
                                }
                        },
                        popoverContent: {
                            Picker("", selection: $selectedValue) {
                                ForEach(pickerItems, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.wheel)
                            .background(backgroundColor)
                            .foregroundColor(placeholderColor)
                            .font(type: fontType)
                            .padding()
                            .accentColor(placeholderColor)
                            .zIndex(1)
                        }
                    )
                }
                Text(localizationType.localized)
                    .font(type: fontType)
                    .foregroundColor(placeholderColor)
                    .background(backgroundColor)
                    .allowsHitTesting(false)
                    .zIndex(2)
                    .padding(placeholderPadding)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let selectedValue {
                    Text(selectedValue)
                        .font(type: fontType)
                        .foregroundColor(foregroundColor)
                        .background(backgroundColor)
                        .allowsHitTesting(false)
                        .zIndex(3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .onChange(of: selectedValue) { newValue in
                if !newValue.isEmpty {
                    value = items.first { $0.displayName == newValue }
                }
            }
            .onChange(of: items) { newValue in
                popoverHidden = true
                
                if !newValue.isEmpty {
                    pickerItems = newValue.map { $0.displayName }
                    selectedValue = ""
                    popoverHidden = false
                } else {
                    pickerItems = [" "]
                    selectedValue = ""
                    popoverHidden = true
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ l: IOLocalizationType,
        items: Binding<[UIModel]>,
        value: Binding<UIModel?>,
        @ViewBuilder pickerOverlay: () -> PickerOverlay
    ) {
        self._value = value
        self._items = items
        self.foregroundColor = Color.black
        self.localizationType = l
        self.pickerOverlay = pickerOverlay()
        self.placeholderColor = Color.gray
        self.fontType = .systemRegular(16)
        self.backgroundColor = Color.white
        self.placeholderPaddingActive = EdgeInsets(top: 0, leading: 12, bottom: 52, trailing: 0)
        self.placeholderPaddingDefault = EdgeInsets(top: 0, leading: 17, bottom: 0, trailing: 0)
        
        self.pickerItems = self.items.map { $0.displayName }
        if let initialValue = self.value {
            self.selectedValue = initialValue.displayName
        } else {
            self.selectedValue = ""
        }
        
        if !self.pickerItems.isEmpty {
            self.popoverHidden = false
        }
    }
    
    private init(
        _ l: IOLocalizationType,
        items: Binding<[UIModel]>,
        value: Binding<UIModel?>,
        pickerOverlay: PickerOverlay,
        foregroundColor: Color,
        placeholderColor: Color,
        fontType: IOFontType,
        backgroundColor: Color,
        placeholderPaddingActive: EdgeInsets,
        placeholderPaddingDefault: EdgeInsets
    ) {
        self._value = value
        self._items = items
        self.localizationType = l
        self.pickerOverlay = pickerOverlay
        self.foregroundColor = foregroundColor
        self.placeholderColor = placeholderColor
        self.fontType = fontType
        self.backgroundColor = backgroundColor
        self.placeholderPaddingActive = placeholderPaddingActive
        self.placeholderPaddingDefault = placeholderPaddingDefault
        
        self.pickerItems = self.items.map { $0.displayName }
        if let initialValue = self.value {
            self.selectedValue = initialValue.displayName
        } else {
            self.selectedValue = ""
        }
        
        if !self.pickerItems.isEmpty {
            self.popoverHidden = false
        }
    }
    
    // MARK: - Modifiers
    
    public func activePlaceholderPadding(_ padding: EdgeInsets) -> IOFloatingPicker<PickerOverlay, Value> {
        return IOFloatingPicker(
            localizationType,
            items: $items,
            value: $value,
            pickerOverlay: pickerOverlay,
            foregroundColor: foregroundColor,
            placeholderColor: placeholderColor,
            fontType: fontType,
            backgroundColor: backgroundColor,
            placeholderPaddingActive: padding,
            placeholderPaddingDefault: placeholderPaddingDefault
        )
    }
    
    public func backgroundColor(_ color: Color) -> IOFloatingPicker<PickerOverlay, Value> {
        return IOFloatingPicker(
            localizationType,
            items: $items,
            value: $value,
            pickerOverlay: pickerOverlay,
            foregroundColor: foregroundColor,
            placeholderColor: placeholderColor,
            fontType: fontType,
            backgroundColor: color,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault
        )
    }
    
    public func font(type: IOFontType) -> IOFloatingPicker<PickerOverlay, Value> {
        return IOFloatingPicker(
            localizationType,
            items: $items,
            value: $value,
            pickerOverlay: pickerOverlay,
            foregroundColor: foregroundColor,
            placeholderColor: placeholderColor,
            fontType: type,
            backgroundColor: backgroundColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault
        )
    }
    
    public func placeholderColor(_ color: Color) -> IOFloatingPicker<PickerOverlay, Value> {
        return IOFloatingPicker(
            localizationType,
            items: $items,
            value: $value,
            pickerOverlay: pickerOverlay,
            foregroundColor: foregroundColor,
            placeholderColor: color,
            fontType: fontType,
            backgroundColor: backgroundColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault
        )
    }
    
    public func placeholderPadding(_ padding: EdgeInsets) -> IOFloatingPicker<PickerOverlay, Value> {
        return IOFloatingPicker(
            localizationType,
            items: $items,
            value: $value,
            pickerOverlay: pickerOverlay,
            foregroundColor: foregroundColor,
            placeholderColor: placeholderColor,
            fontType: fontType,
            backgroundColor: backgroundColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: padding
        )
    }
    
    public func textColor(_ color: Color) -> IOFloatingPicker<PickerOverlay, Value> {
        return IOFloatingPicker(
            localizationType,
            items: $items,
            value: $value,
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

#if DEBUG
struct IOFloatingPicker_Previews: PreviewProvider {
    
    struct IOFloatingPickerDemo: View {
    
        @State var value: IOPickerUIModel<Int>?
        @State var items = [
            IOPickerUIModel(displayName: "Item 0", valueType: Int.self, value: 0),
            IOPickerUIModel(displayName: "Item 1", valueType: Int.self, value: 1),
            IOPickerUIModel(displayName: "Item 2", valueType: Int.self, value: 2),
            IOPickerUIModel(displayName: "Item 3", valueType: Int.self, value: 3),
            IOPickerUIModel(displayName: "Item 4", valueType: Int.self, value: 4),
            IOPickerUIModel(displayName: "Item 5", valueType: Int.self, value: 5),
            IOPickerUIModel(displayName: "Item 6", valueType: Int.self, value: 6),
            IOPickerUIModel(displayName: "Item 7", valueType: Int.self, value: 7),
            IOPickerUIModel(displayName: "Item 8", valueType: Int.self, value: 8),
            IOPickerUIModel(displayName: "Item 9", valueType: Int.self, value: 9)
        ]
        
        var body: some View {
            IOFloatingPicker(
                .init(rawValue: "Item"),
                items: $items,
                value: $value,
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
        prepare()
        return IOFloatingPickerDemo()
    }
}
#endif
