//
//  ContentView.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .font(.headline)
            .fontWeight(.regular)
            .foregroundColor(Color.red)
            .multilineTextAlignment(.leading)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
