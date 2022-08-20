//
//  ContentView.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import SwiftUI
import SwiftUISampleAppComponents

struct ContentView: View {
    
    @State var emailAddress: String = ""
    
    var body: some View {
        FloatingTextField(.init(rawValue: "Email address"), text: self.$emailAddress)
            .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
