//
//  RegisterView.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import SwiftUI
import SwiftUISampleAppComponents

struct RegisterView: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(type: .registerTitle)
                .foregroundColor(.black)
                .font(type: .regular(36))
                .multilineTextAlignment(.leading)
            FloatingTextField(
                .registerInputEmailAddress,
                text: $emailText
            )
            .keyboardType(.emailAddress)
            .padding(.top, 32)
            FloatingTextField(
                .registerInputCreatePassword,
                text: $passwordText
            )
            .padding(.top, 16)
            PrimaryButton(.commonNextUppercased)
                .padding(.top, 16)
            Spacer()
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
