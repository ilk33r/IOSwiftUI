//
//  HTTPDebuggerDetailView.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

struct HTTPDebuggerDetailView: View {
    
    // MARK: - DI
    
    @IOInject private var appleSettings: IOAppleSetting
    
    // MARK: - Privates
    
    private let networkHistory: IOHTTPNetworkHistory?
    
    @State private var tabCurrentPage = 0
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                ZStack(alignment: .top) {
                    IOTabControlView(
                        page: $tabCurrentPage,
                        tabControlHeight: 64,
                        tabTitles: [
                            "Request",
                            "Response"
                        ]
                    ) {
                        HStack {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 16) {
                                    HStack(spacing: 8) {
                                        Text(networkHistory?.icon ?? "")
                                            .font(type: .systemRegular(10))
                                            .foregroundColor(.black)
                                        Text(networkHistory?.methodType ?? "")
                                            .font(type: .systemRegular(10))
                                            .foregroundColor(.black)
                                        Text("\(networkHistory?.responseStatusCode ?? 0)")
                                            .font(type: .systemRegular(14))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Text("Headers")
                                        .font(type: .systemSemibold(14))
                                        .foregroundColor(.gray)
                                    
                                    Text(networkHistory?.requestHeaders ?? "")
                                        .font(type: .systemRegular(12))
                                        .foregroundColor(.black)
                                    
                                    Text("Body")
                                        .font(type: .systemSemibold(14))
                                        .foregroundColor(.gray)
                                    
                                    Text(prettyPrintedRequestBody())
                                        .font(type: .systemRegular(12))
                                        .foregroundColor(.black)
                                    
                                }
                                .padding(24)
                            }
                            .frame(
                                width: proxy.size.width,
                                height: proxy.size.height - 64,
                                alignment: .top
                            )
                            
                            ScrollView {
                                VStack(alignment: .leading, spacing: 16) {
                                    HStack(spacing: 8) {
                                        Text(networkHistory?.icon ?? "")
                                            .font(type: .systemRegular(10))
                                            .foregroundColor(.black)
                                        Text(networkHistory?.methodType ?? "")
                                            .font(type: .systemRegular(10))
                                            .foregroundColor(.black)
                                        Text("\(networkHistory?.responseStatusCode ?? 0)")
                                            .font(type: .systemRegular(14))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Text("Headers")
                                        .font(type: .systemSemibold(14))
                                        .foregroundColor(.gray)
                                    
                                    Text(networkHistory?.responseHeaders ?? "")
                                        .font(type: .systemRegular(12))
                                        .foregroundColor(.black)
                                    
                                    Text("Body")
                                        .font(type: .systemSemibold(14))
                                        .foregroundColor(.gray)
                                    
                                    Text(networkHistory?.responseBody ?? "")
                                        .font(type: .systemRegular(12))
                                        .foregroundColor(.black)
                                    
                                }
                                .padding(24)
                            }
                            .frame(
                                width: proxy.size.width,
                                height: proxy.size.height - 64,
                                alignment: .top
                            )
                        }
                    }
                    Color.white
                        .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                        .ignoresSafeArea()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("HTTP Logger")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(.leading, 48)
                            
                            Button {
                                shareHistory()
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                            }
                            .foregroundColor(.black)
                            .frame(width: 32)
                            
                            Button {
                                appleSettings.set(false, for: .debugHTTPMenuToggle)
                            } label: {
                                Image(systemName: "xmark")
                            }
                            .foregroundColor(.black)
                            .frame(width: 32)
                            .padding(.leading, 16)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(false)
    }
    
    // MARK: - Initialization Methods
    
    init(networkHistory: IOHTTPNetworkHistory?) {
        self.networkHistory = networkHistory
    }
    
    // MARK: - Helper Methods
    
    private func prettyPrintedRequestBody() -> String {
        if networkHistory?.requestBody.isEmpty ?? true {
            return ""
        }
        
        guard let requestBodyData = networkHistory!.requestBody.data(using: .utf8) else { return "" }
        guard let requestBodyJsonObject = try? JSONSerialization.jsonObject(with: requestBodyData) else { return "" }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBodyJsonObject, options: .prettyPrinted)  else { return "" }
        
        return String(data: jsonData, encoding: .utf8) ?? ""
    }
    
    private func shareHistory() {
        var activityItems = networkHistory?.methodType ?? ""
        activityItems += " \(networkHistory?.responseStatusCode ?? 0)"
        activityItems += "\n\n"
        
        activityItems += "Request"
        activityItems += " ------------------------------------"
        activityItems += "\n\n"
        
        activityItems += "Headers"
        activityItems += "\n"
        activityItems += networkHistory?.requestHeaders ?? ""
        activityItems += "\n\n"
        
        activityItems += "Body"
        activityItems += "\n"
        activityItems += prettyPrintedRequestBody()
        activityItems += "\n\n"
        
        activityItems += "Response"
        activityItems += " ------------------------------------"
        activityItems += "\n\n"
        
        activityItems += "Headers"
        activityItems += "\n"
        activityItems += networkHistory?.responseHeaders ?? ""
        activityItems += "\n\n"
        
        activityItems += "Body"
        activityItems += "\n"
        activityItems += networkHistory?.responseBody ?? ""
        activityItems += "\n\n"

        NotificationCenter.default.post(
            name: .httpDebuggerShareLog,
            object: nil,
            userInfo: ["httpHistory": activityItems]
        )
    }
}
