//
//  MessagesContainerView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import SwiftUI

struct MessagesContainerView: View {
    @State private var isComposeMessageViewPresented = false
    @State private var usernameToMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, Messages!")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Malo Shah")
                                .font(.system(size: 20, weight: .bold))
                                .padding()
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Image(systemName: "video")
                                    .resizable()
                                    .scaledToFit()
                                    .font(.system(size: 20))
                                    .padding(.trailing, 10)
                                
                                NavigationLink(destination: ComposeMessageView(isPresented: $isComposeMessageViewPresented, usernameToMessage: $usernameToMessage)) {
                                    Image(systemName: "square.and.pencil")
                                        .resizable()
                                        .scaledToFit()
                                        .font(.system(size: 20))
                                }
                            }
                        }
                    }
                
                TextField("Enter username to message", text: $usernameToMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
        }
    }
}

struct MessagesContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesContainerView()
    }
}
