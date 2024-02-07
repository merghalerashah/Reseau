//
//  ProfileHeader.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import Foundation
import SwiftUI

struct ProfileHeader: View {
    
    let user: User
    
    var body: some View {
        HStack {
            // Convert userImage Data to UIImage
            if let imageData = user.userImage, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(60)
                    .clipped()
                    .padding()
            } else {
                // Fallback image if userImage is nil
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(60)
                    .clipped()
                    .padding()
            }
            Spacer()
            
            VStack {
                Text("205")
                    .font(Font.system(size: 16, weight: .bold))
                Text("Posts")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()

            VStack {
                Text("364")
                    .font(Font.system(size: 16, weight: .bold))
                Text("Followers")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()
            VStack {
                           Text("358")
                               .font(Font.system(size: 16, weight: .bold))
                           Text("Following")
                               .font(Font.system(size: 14, weight: .medium))
                       }
                       Spacer()
                   }

                   HStack {
                       Text("Sdsu #Student \nStraight Edge \nAiming to make this planet #green \nLoves Football \nFan of @fcbarcelona @liverpoolfc \nmaloshah.com")
                           .font(.caption)
                           .padding(.horizontal)
                       Spacer()
                   }
                   
               }
           }

