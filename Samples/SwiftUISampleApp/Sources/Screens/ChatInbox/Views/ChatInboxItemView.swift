//
//  ChatInboxItemView.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import SwiftUI

struct ChatInboxItemView: View {
    
    @Binding private var isTapped: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image("pwChatAvatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Rev Shawn")
                        .font(type: .bold(13))
                        .foregroundColor(.black)
                    Text("Wanted to ask if you’re available for a portrait shoot next week.")
                        .lineLimit(3)
                        .font(type: .regular(13))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 6)
                }
                .padding(.leading, 16)
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.top, 16)
            .padding(.bottom, 16)
            Rectangle()
                .fill(Color.colorPassthrought)
                .frame(height: 1)
        }
        .onTapGesture {
            isTapped = true
        }
    }
    
    init(isTapped: Binding<Bool>) {
        self._isTapped = isTapped
    }
}

struct ChatInboxItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChatInboxItemView(isTapped: Binding.constant(false))
            .previewLayout(.sizeThatFits)
    }
}
