import Alamofire
import Foundation
import SwiftUI

enum APIError: Error {
    case unauthorized
    case notFound
    case serverError
    case invalidResponse
    case requestFailed(Error)
    case networkError(Error)
}


class APIManager {
    static let shared = APIManager()
    
    private let sessionManager: Session
    
    private var jwtToken:String=""
    
    private let URL="https://example.com";
    
    private init() {
        
        self.jwtToken = ""
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30
        sessionManager = Session(configuration: configuration)
    }
    
    
    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let loginURL = URL+"https://example.com/login" // Replace with your login API endpoint
        
        let parameters: Parameters = [
            "username": username,
            "password": password
        ]
        
        sessionManager.request(loginURL, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: String.self){ response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func refreshToken(completion: @escaping (Result<String, Error>) -> Void) {
        let refreshTokenURL = URL+"https://example.com/refreshToken" // Replace with your token refreshing API endpoint
        
        sessionManager.request(refreshTokenURL, method: .post)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: String.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // MARK: - HTTP Methods
    
    
    
    func get<T: Decodable>(url: String, headers: [String: String], completion: @escaping (Result<T, APIError>) -> Void) {
        var modifiedHeaders = headers
        modifiedHeaders["Authorization"] = "Bearer \(jwtToken)"
        
        sessionManager.request(URL+url, method: .get, headers:  HTTPHeaders(modifiedHeaders))
            .validate()
            .responseDecodable(of: T.self)  { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(.requestFailed(error)))
                }
            }
    }
    
    func post<T: Decodable>(url: String, parameters: [String: Any], headers: [String: String], completion: @escaping (Result<T, APIError>) -> Void) {
        var modifiedHeaders = headers
        modifiedHeaders["Authorization"] = "Bearer \(jwtToken)"
        sessionManager.request(URL+url, method: .post, parameters: parameters, headers: HTTPHeaders(modifiedHeaders))
            .validate()
            .responseDecodable(of: T.self)   { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(.requestFailed(error)))
                }
            }
    }
    
    func put<T: Decodable>(url: String, parameters: [String: Any], headers: [String: String], completion: @escaping (Result<T, APIError>) -> Void) {
        var modifiedHeaders = headers
        modifiedHeaders["Authorization"] = "Bearer \(jwtToken)"
        
        sessionManager.request(URL+url, method: .put, parameters: parameters, headers: HTTPHeaders(modifiedHeaders))
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(.requestFailed(error)))
                }
            }
    }
    
    func delete<T: Decodable>(url: String, headers: [String: String], completion: @escaping (Result<T, APIError>) -> Void) {
        var modifiedHeaders = headers
        modifiedHeaders["Authorization"] = "Bearer \(jwtToken)"
        sessionManager.request(URL+url, method: .delete, headers: HTTPHeaders(modifiedHeaders))
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(.requestFailed(error)))
                }
            }
    }
    
    // MARK: - Image Uploading
    
    func uploadImages<T: Decodable>(url: String, images: [UIImage], headers: [String: String], completion: @escaping (Result<T, APIError>) -> Void) {
        // Convert UIImage to Data
        let imageDataArray = images.compactMap { image in
            image.jpegData(compressionQuality: 0.8)
        }
        var modifiedHeaders = headers
        modifiedHeaders["Authorization"] = "Bearer \(jwtToken)"
        
        sessionManager.upload(multipartFormData: { multipartFormData in
            for (index, imageData) in imageDataArray.enumerated() {
                multipartFormData.append(imageData, withName: "image\(index)", fileName: "image\(index).jpg", mimeType: "image/jpeg")
            }
        }, to: URL+url, headers: HTTPHeaders(modifiedHeaders))
        .validate()
        .responseDecodable(of: T.self){ response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(.requestFailed(error)))
            }
        }
    }
    
    // MARK: - Image Downloading
    
    func downloadImage(url: String, completion: @escaping (Result<Image, APIError>) -> Void) {
        sessionManager.request(URL+url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let uiImage = UIImage(data: data) {
                        let image = Image(uiImage: uiImage)
                        completion(.success(image))
                    } else {
                        completion(.failure(.invalidResponse))
                    }
                case .failure(let error):
                    completion(.failure(.requestFailed(error)))
                }
            }
    }
}
