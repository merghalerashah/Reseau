//
//  LogoView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/3/24.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("logo") // Ensure the image asset is named 'logo' in your asset catalog
            .resizable() // Make the image resizable
            .aspectRatio(contentMode: .fit) // Maintain the aspect ratio
            .frame(width: 200, height: 200) // Set the frame (adjust the size as needed)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
