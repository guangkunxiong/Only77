import Foundation

class APIManager {
    
    // MARK: - Singleton
    static let shared = APIManager()
    private init() {}
    
    // MARK: - Properties
    private let baseURL = "http://localhost:5121/api/"
    private let session = URLSession.shared
    private var jwtToken: String?
    
    // MARK: - Public Methods
    func setJWTToken(_ token: String) {
        jwtToken = token
    }
    
    func request<T: Codable>(endpoint: String, method: String, params: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void) {
        // Create URL
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Add JWT authorization header if token exists
        if let token = jwtToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Add parameters to request body
        if let params = params {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        // Send request
        let task = session.dataTask(with: request) { (data, response, error) in
            // Handle error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Handle response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            // Parse response
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }
        
        task.resume()
    }
    
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        let params = ["username": username, "password": password]
        
        request(endpoint: "users/login", method: "POST", params: params, completion: completion)
    }
    
    
}

// MARK: - Error Handling
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError
}
