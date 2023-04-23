//
//  FloatingDatePicker.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

public struct FloatingDatePicker: View, IOValidatable {
    
    // MARK: - Publics
    
    public var validationText: String? {
        if let date {
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    // MARK: - Identifiable
    
    public var id = UUID().uuidString
    
    // MARK: - Privates
    
    private let dateFormatter: DateFormatter
    private let localizationType: IOLocalizationType
    
    @Binding private var date: Date?
    
    @ObservedObject private var validationObservedObject = IOValidatorObservedObject()
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading) {
            EmptyView()
            /*
            IOFloatingDatePicker(
                localizationType,
                date: $date,
                dateFormat: dateFormatter.dateFormat
            ) {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(height: 52)
            }
            .textColor(Color.black)
            .placeholderColor(Color.colorPlaceholder)
            .backgroundColor(Color.white)
            .activePlaceholderPadding(EdgeInsets(top: 0, leading: 12, bottom: 52, trailing: 0))
            .placeholderPadding(EdgeInsets(top: 0, leading: 17, bottom: 0, trailing: 0))
            .font(type: .regular(14))
            .padding(.top, 8)
            .frame(height: 60)
            Text(validationObservedObject.errorMessage)
                .font(type: .regular(12))
                .foregroundColor(.colorTabEnd)
                .padding(.top, 4)
                .hidden(isHidden: $validationObservedObject.isValidated)
                  */
        }
    }
    
    public init(
        _ l: IOLocalizationType,
        date: Binding<Date?>
    ) {
        self.localizationType = l
        self._date = date
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "dd MMM yyyy"
    }
    
    // MARK: - Validation
    
    public func observedObject() -> IOValidatorObservedObject {
        validationObservedObject
    }
}

#if DEBUG
struct FloatingDatePicker_Previews: PreviewProvider {
    
    struct FloatingDatePickerDemo: View {
    
        @State var birthDate: Date?
        
        var body: some View {
            FloatingDatePicker(
                .init(rawValue: "Birthdate"),
                date: $birthDate
            )
            .padding(20)
            .frame(height: 60)
        }
    }
    
    static var previews: some View {
        prepare()
        return FloatingDatePickerDemo()
    }
}
#endif
