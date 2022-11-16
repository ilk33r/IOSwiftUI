//
//  HTTPDebuggerCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

#if DEBUG

import SwiftUI
import IOSwiftUIInfrastructure

struct HTTPDebuggerCellView: View {
    
    // MARK: - Defs
    
    typealias Handler = (_ history: IOHTTPLogger.NetworkHistory) -> Void
    
    // MARK: - Privates
    
    private let history: IOHTTPLogger.NetworkHistory
    private let tapHandler: Handler?
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            HStack {
                Text(history.icon)
                Text(history.methodType)
                    .font(type: .systemRegular(10))
                Text("\(history.responseStatusCode)")
                    .font(type: .systemSemibold(14))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            
            Text(history.path)
                .font(type: .systemRegular(12))
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 1)
        }
        .padding(.top, 16)
        .onTapGesture {
            tapHandler?(history)
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        history: IOHTTPLogger.NetworkHistory,
        handler: Handler?
    ) {
        self.history = history
        self.tapHandler = handler
    }
}

struct HTTPDebuggerCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        HTTPDebuggerCellView(
            history: IOHTTPLogger.NetworkHistory(
                icon: "\u{00002705}",
                methodType: "POST",
                path: "Handshake/Index",
                requestHeaders: "",
                requestBody: "",
                responseHeaders: "",
                responseBody: "",
                responseStatusCode: 200
            ), handler: { _ in
                
            }
        )
        .previewLayout(.sizeThatFits)
    }
}
#endif