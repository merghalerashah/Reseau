//
//  SearchContainerView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import SwiftUI

struct SearchContainerView: View {
    @State private var searchText: String = ""

    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, placeholder: "Search")
            PostGridView(posts: filteredPosts)
        }
    }

    // Assuming you have a way to filter posts based on searchText.
    // If not, just use MockData.posts directly in PostGridView.
    private var filteredPosts: [Post] {
        if searchText.isEmpty {
            return MockData.posts
        } else {
            return MockData.posts.filter { post in
                // Replace this with your actual filtering logic
                post.caption?.contains(searchText) ?? false
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchContainerView()
    }
}
