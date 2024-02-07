//
//  TimeLineContainerView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import Foundation
import SwiftUI

struct TimeLineContainerView: View {
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(MockData.stories, id: \.id) { story in
                            StoryView(story: story)
                        }
                    }
                }
                ForEach(MockData.posts, id: \.id) { post in
                    PostView(post: post, screenWidth: UIScreen.main.bounds.size.width)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("logo")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 130)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 10)
                        NavigationLink(destination: MessagesContainerView()) {
                            Image(systemName: "message")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                }
            }
        }
    }
}

struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineContainerView()
    }
}
