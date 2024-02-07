//
//  NetworkService.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/3/24.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case networkError(Error)
    // Add more error types as needed
}

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://razo.network"
    
    // Function to perform GET requests
    func get(_ endpoint: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    // Function to perform POST requests
    func post(_ endpoint: String, body: Data, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    // Function to sign up
    func signUp(username: String, email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let endpoint = "/signup"
        let body: [String: Any] = ["username": username, "email": email, "password": password]
        guard let data = try? JSONSerialization.data(withJSONObject: body) else {
            completion(.failure(.invalidData))
            return
        }
        
        post(endpoint, body: data) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Function to log in
    func login(username: String, password: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let endpoint = "/login"
        let body: [String: Any] = ["username": username, "password": password]
        guard let data = try? JSONSerialization.data(withJSONObject: body) else {
            completion(.failure(.invalidData))
            return
        }
        
        post(endpoint, body: data) { result in
            switch result {
            case .success(let data):
                if let token = String(data: data, encoding: .utf8) {
                    completion(.success(token))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Function to post a story with image
    func postStory(storyContent: String, image: UIImage?, videoURL: URL?, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let endpoint = "/postStory"
        var body: [String: Any] = ["storyContent": storyContent]
        
        if let image = image {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                completion(.failure(.invalidData))
                return
            }
            body["imageData"] = imageData.base64EncodedString()
        }
        
        if let videoURL = videoURL {
            guard let videoData = try? Data(contentsOf: videoURL) else {
                completion(.failure(.invalidData))
                return
            }
            body["videoData"] = videoData.base64EncodedString()
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: body) else {
            completion(.failure(.invalidData))
            return
        }
        
        post(endpoint, body: data) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Function to handle response
    func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let error = error {
            completion(.failure(.networkError(error)))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            completion(.failure(.invalidResponse))
            return
        }
        
        guard let data = data else {
            completion(.failure(.invalidData))
            return
        }
        
        completion(.success(data))
    }
    
    // Function to upload a video
    func uploadVideo(storyContent: String, videoData: Data, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let endpoint = "/uploadVideo"
        let body: [String: Any] = ["storyContent": storyContent, "videoData": videoData.base64EncodedString()]
        
        guard let data = try? JSONSerialization.data(withJSONObject: body) else {
            completion(.failure(.invalidData))
            return
        }
        
        post(endpoint, body: data) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Function to upload an image
    func uploadImage(image: UIImage, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let endpoint = "/uploadImage"
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(.invalidData))
            return
        }
        let body: [String: Any] = ["imageData": imageData.base64EncodedString()]
        
        guard let data = try? JSONSerialization.data(withJSONObject: body) else {
            completion(.failure(.invalidData))
            return
        }
        
        post(endpoint, body: data) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Function to upload a text story
    func uploadTextStory(text: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let endpoint = "/uploadTextStory"
        let body: [String: Any] = ["text": text]
        
        guard let data = try? JSONSerialization.data(withJSONObject: body) else {
            completion(.failure(.invalidData))
            return
        }
        
        post(endpoint, body: data) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Function to upload a post with image
    func uploadPost(caption: String, image: UIImage, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let endpoint = "/uploadPost"
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(.invalidData))
            return
        }
        
        let body: [String: Any] = ["caption": caption, "imageData": imageData.base64EncodedString()]
        
        guard let data = try? JSONSerialization.data(withJSONObject: body) else {
            completion(.failure(.invalidData))
            return
        }
        
        post(endpoint, body: data) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
