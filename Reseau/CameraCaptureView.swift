//
//  CameraCaptureView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/4/24.
//

import Foundation
import SwiftUI
import UIKit

struct CameraCaptureView: View {
    var onCapture: (UIImage) -> Void

    var body: some View {
        ImagePicker(sourceType: .camera) { image in
            if let capturedImage = image {
                onCapture(capturedImage)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

