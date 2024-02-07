//
//  ProfileContainerView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//


import SwiftUI

struct ProfileContainerView: View {
    private let user: User

    init() {
        // Fetch the first user from your mock data
        // Make sure that MockData.generate() has been called before this
        self.user = MockData.users.first ?? User(context: MockData.context)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ProfileHeader(user: user)
                    ProfileControlButtonsView()
                    ProfileMediaSelectionView()
                    PostGridView(posts: MockData.posts)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(user.userName ?? "Unknown")
                        .font(.system(size: 20, weight: .bold))
                        .padding()
                        .frame(width: UIScreen.main.bounds.size.width / 2, alignment: .leading)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 10)
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 25, height: 20)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileContainerView()
        }
    }
}
