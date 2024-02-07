//
//  ProfileControlButtonsView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import SwiftUI

struct ProfileControlButtonsView: View {
    @State private var isEditingProfile = false

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Button(action: {
                isEditingProfile = true
            }) {
                Text("Edit Profile")
                    .font(Font.system(size: 13, weight: .medium))
                    .padding(.vertical, 9)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.primary, lineWidth: 0.2)
                    )
            }
            .padding(.leading)
            .sheet(isPresented: $isEditingProfile) {
                EditProfileView()
            }

            // The code for the "Saved" button remains unchanged
            Button(action: {

            }) {
                Text("Saved")
                    .font(Font.system(size: 13, weight: .medium))
                    .padding(.vertical, 9)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.primary, lineWidth: 0.2)
                    )
            }
            .padding(.trailing)
        }
    }
}

struct ProfileControlButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileControlButtonsView()
    }
}
