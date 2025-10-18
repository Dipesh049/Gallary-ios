//
//  APIService.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//


import Foundation

final class APIService {

    // MARK: - Singleton (Optional)
    static let shared = APIService()
    
    // MARK: - Private init for Singleton
    private init() {}
    
    func prepareRequest(endPoint: APIEndpoint, headers: [String: String]? = nil) -> URLRequest {
        var request:URLRequest
            request = makeRequest(path: endPoint.path, query: endPoint.query, httpMethod: endPoint.httpMethod)
        
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = 60
        request.cachePolicy = .reloadIgnoringLocalCacheData
        return request
    }
    
    private func makeRequest(path: String, query:String? = nil, httpMethod: HTTPMethod) -> URLRequest {
        
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path += path
        urlComponents?.query = query
        
        let url = urlComponents?.url
        
        var request = URLRequest(url: url!)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }

    // MARK: - Generic API Request
    func request<T: Decodable>(_ type: T.Type,
        request: URLRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // MARK: - Image Downloading (Raw Data)
    func downloadImageData(from url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url else {completion(.failure(APIError.invalidURL)); return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                    completion(.failure(error))
                return
            }

            guard let data = data else {
                    completion(.failure(APIError.noData))
                return
            }

                completion(.success(data))
        }
        task.resume()
    }

}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - Error Types
enum APIError: Error {
    case invalidURL
    case noData
    case decodingFailed
}
