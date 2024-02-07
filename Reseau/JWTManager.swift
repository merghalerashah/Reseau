//
//  JWTManager.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/3/24.
//

import Foundation
import JWTKit

struct JWTManager {
    let signer: JWTSigner

    init() {
        // Load the private key from a secure location
        let privateKey: String = """
        -----BEGIN PRIVATE KEY-----
        MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgeNqZbR+eAvJ4wtxl
        T603wDuENGqGSPCaCMA8RXG53yKgCgYIKoZIzj0DAQehRANCAAR1QnMxLCaQHZOW
        TFhvchYc6CnzMT88d4KXvq+RyKzV9VOKTrzPa7MMdoGwwUb33qh8jy+OU+BVkggP
        ailM2/UK
        -----END PRIVATE KEY-----
        """

        do {
            // Initialize the signer with the private key
            signer = try JWTSigner.es256(key: .private(pem: privateKey))
        } catch {
            fatalError("Failed to initialize JWT signer: \(error)")
        }
    }

    func generateJWT() -> String? {
        let payload = JWTPayload(
            iss: "7141875b-abe0-4303-b647-f6e6d1c703bc",
            iat: Date(),
            exp: Date().addingTimeInterval(3600), // Expires in 1 hour
            aud: "appstoreconnect-v1",
            scope: ["GET /v1/apps?filter[platform]=IOS"]
        )

        do {
            // Encode the JWT with the header and payload
            let token = try signer.sign(payload)
            return token
        } catch {
            print("Failed to sign JWT: \(error)")
            return nil
        }
    }
}

