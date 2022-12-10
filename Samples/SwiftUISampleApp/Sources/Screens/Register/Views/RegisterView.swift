//
//  RegisterView.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

struct RegisterView: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    
    var body: some View {
        IOFormGroup(.commonDone, handler: {
            
        }, content: {
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
        })
    }
}

#if DEBUG
struct RegisterView_Previews: PreviewProvider {
    
    struct RegisterViewDemo: View {
        
        var body: some View {
            RegisterView()
        }
    }
    
    static var previews: some View {
        RegisterViewDemo()
    }
}
#endif
