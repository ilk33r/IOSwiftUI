//
//  ContentView.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import SwiftUI
import SwiftUISampleAppComponents

struct ContentView: View {
    var body: some View {
        SecondaryButton(.init(rawValue: "Test"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
