//
//  JWTPayload.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/3/24.
//

import Foundation
import JWTKit

struct JWTPayload: JWTKit.JWTPayload {
    // Your existing properties
    var iss: String
    var iat: Date
    var exp: Date
    var aud: String
    var scope: [String]

    // Conformance to JWTKit.JWTPayload requires this method
    func verify(using signer: JWTSigner) throws {
        // Implement verification logic here
        // For example, you might check if the current date is before the 'exp' date
        let currentTime = Date().timeIntervalSince1970
        guard currentTime < exp.timeIntervalSince1970 else {
            throw JWTError.claimVerificationFailure(name: "exp", reason: "Token has expired")
        }
        // Add other verification checks as necessary
    }
}
