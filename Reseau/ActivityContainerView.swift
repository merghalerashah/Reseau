//
//  ActivityContainerView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import Foundation
import SwiftUI

struct ActivityContainerView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                // Make sure that 'activities' is a static property in your MockData structure
                ForEach(MockData.activities, id: \.id) { activity in
                    ActivityView(activity: activity)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Activity")
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
                }
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityContainerView()
    }
}
