//
//  MessageService.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/3/24.
//

import Foundation


class MessageService {
    static let shared = MessageService()

    func sendMessage(username: String, messageContent: String, linkType: LinkType, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "https://razo.network/api/sendmessage") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let messageData = [
            "username": username,
            "messageContent": messageContent,
            "linkType": linkType.rawValue // Assuming LinkType has a rawValue that is String
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: messageData, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            // Handle the response here. For simplicity, we're just returning success.
            completion(.success(true))
        }.resume()
    }
}
