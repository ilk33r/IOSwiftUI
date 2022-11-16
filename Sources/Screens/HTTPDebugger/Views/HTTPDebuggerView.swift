//
//  HTTPDebuggerView.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

#if DEBUG
import SwiftUI
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

struct HTTPDebuggerView: View {
    
    // MARK: - Defs
    
    private struct History: Identifiable {
        
        var id = UUID()
        
        let history: IOHTTPLogger.NetworkHistory
    }
    
    // MARK: - DI
    
    @IOInject private var appleSettings: IOAppleSettingImpl
    
    // MARK: - Privates
    
    @IOInject private var httpLogger: IOHTTPLogger
    
    @State private var detailHistory: IOHTTPLogger.NetworkHistory?
    @State private var navigateToDetail = false
    @State private var networkHistory: [History] = []
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { proxy in
                    ZStack(alignment: .top) {
                        ZStack(alignment: .leading) {
                            List {
                                ForEach(networkHistory) { item in
                                    HTTPDebuggerCellView(history: item.history) { history in
                                        detailHistory = history
                                        navigateToDetail = true
                                    }
                                }
                            }
                            .listStyle(.plain)
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
                                    .padding(.leading, 32)
                                Button {
                                    appleSettings.set(false, for: .debugHTTPMenuToggle)
                                } label: {
                                    Image(systemName: "xmark")
                                }
                                .foregroundColor(.black)
                                .frame(width: 32)
                            }
                        }
                    }
                    .onAppear {
                        let loggerHistory = httpLogger.networkHistory.reversed()
                        networkHistory = loggerHistory.map { History(history: $0) }
                    }
                }
                
                NavigationLink(isActive: $navigateToDetail) {
                    HTTPDebuggerDetailView(networkHistory: detailHistory)
                } label: {
                    EmptyView()
                }
            }
            .navigationViewStyle(.stack)
            .navigationBarHidden(false)
        }
    }
}
#endif
