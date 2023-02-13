//
//  IOActionSheetModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.02.2023.
//

import Foundation
import SwiftUI

public extension View {
    
    @ViewBuilder
    func actionSheet(
        data: Binding<IOAlertData?>
    ) -> some View {
        modifier(IOActionSheetModifier(data: data))
    }
}

struct IOActionSheetModifier: ViewModifier {
    
    @Binding private var data: IOAlertData?
    
    init(
        data: Binding<IOAlertData?>
    ) {
        self._data = data
    }
    
    func body(content: Content) -> some View {
        content
            .actionSheet(item: _data) { it in
                ActionSheet(
                    title: Text(it.title ?? ""),
                    message: it.message.isEmpty ? nil : Text(it.message),
                    buttons: sheetButtons(item: it)
                )
            }
    }
    
    // MARK: - Helper Methods
    
    private func sheetButtons(item: IOAlertData) -> [ActionSheet.Button] {
        var sheetButtons = [ActionSheet.Button]()
        
        item.buttons.enumerated().forEach { it in
            if it.offset == item.buttons.count - 1 {
                sheetButtons.append(
                    .destructive(
                        Text(it.element),
                        action: {
                            item.handler?(it.offset)
                        }
                    )
                )
            } else {
                sheetButtons.append(
                    .default(
                        Text(it.element),
                        action: {
                            item.handler?(it.offset)
                        }
                    )
                )
            }
        }
        
        return sheetButtons
    }
}
