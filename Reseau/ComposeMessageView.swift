//
//  ComposeMessageView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/3/24.
//

import Foundation
import SwiftUI

struct ComposeMessageView: View {
    @Binding var isPresented: Bool
    @Binding var usernameToMessage: String
    @State private var messageContent = "" // State variable for message content
    @State private var linkType = LinkType.none // State variable for link type
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Message content", text: $messageContent)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Picker("Link", selection: $linkType) {
                    Text("No Link").tag(LinkType.none)
                    Text("Link to Post").tag(LinkType.post)
                    Text("Link to Video").tag(LinkType.video)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Button("Send") {
                    sendMessage()
                }
                .padding()
            }
            .navigationBarTitle("New Message", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }

    private func sendMessage() {
        MessageService.shared.sendMessage(username: usernameToMessage, messageContent: messageContent, linkType: linkType) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    // Handle success, e.g., show a confirmation to the user
                    print("Message sent successfully")
                case .failure(let error):
                    // Handle failure, e.g., show an error message to the user
                    print("Failed to send message: \(error)")
                }
                isPresented = false
            }
        }
    }
}

struct ComposeMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeMessageView(isPresented: .constant(true), usernameToMessage: .constant("Username"))
    }
}
