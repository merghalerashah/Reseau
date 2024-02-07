//
//  MediaPickerItem .swift
//  Reseau
//
//  Created by Merghalera Shah on 2/4/24.
//

import SwiftUI
import PhotosUI

enum MediaPickerItem: Identifiable {
    case image(UIImage)
    case video(URL)
    case cameraCapture(UIImage)
    case text(String)

    var id: UUID {
        switch self {
        case .image:
            return UUID()
        case .video:
            return UUID()
        case .cameraCapture:
            return UUID()
        case .text:
            return UUID()
        }
    }
}
