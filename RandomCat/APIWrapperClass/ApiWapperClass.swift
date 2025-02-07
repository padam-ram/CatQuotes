//
//  ApiWapperClass.swift
//  RandomCat
//
//  Created by sai sitaram on 07/02/25.
//

import Foundation
import UIKit

    
//MARK: - Request Type

enum RequestType: String {
    case GET
    case POST
}

//MARK: - Request Error

enum NetworkError: Error {
    case domainError
    case decodingError
    case noDataError
}


//MARK: - Request url
struct RequestURL  {
    let url : URL
}


//MARK: - APIWapperClass

class APIWapperClass : NSObject {
    
    static let shared = APIWapperClass()
    
    //MARK: - Get Method
    func getCall<T: Codable>(url: RequestURL,
                             _ modelType: T.Type,
                             _ headers: [String:String]? = [:],
                             completionHandler: @escaping (Result<T, NetworkError>) -> Void ) {
        
        let serviceUrl = URLComponents(string: url.url.description)
        
        guard let componentURL = serviceUrl?.url else { return }
        var urlRequest = URLRequest(url: componentURL)
        urlRequest.httpMethod = RequestType.GET.rawValue
        urlRequest.timeoutInterval = 120
        urlRequest.allHTTPHeaderFields = headers
        serviceRequestCall(urlRequest, modelType ,completionHandler)
    }
    
    private func serviceRequestCall<T: Codable>(_ urlRequest:URLRequest,
                                                _ modelType: T.Type,
                                                _ completion: @escaping (Result<T,NetworkError>) -> Void) {
        
        //If internet not available
        if !Reachability.isConnectedToNetwork() {
            DispatchQueue.main.async {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    let window = windowScene.windows.first { $0.isKeyWindow }
                    window?.showToast(message: ErrorMessages.noInternet)
                }
            }
        }
        
        let url =  urlRequest.url?.description
        print("URL:--->",url as Any)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
        guard response is HTTPURLResponse else {return}
        
            
            if error != nil {
                completion(.failure(.noDataError))
            }
            
            guard let jsonData = data, !jsonData.isEmpty else {
                completion(.failure(.noDataError))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 404 || response.statusCode == 500 {
                    completion(.failure(.noDataError) )
                }
            }

            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(responseModel))
                } catch {
                    //type of failure
                    completion(.failure(.decodingError))
                    print(error)
                }
            } else {
                completion(.failure(.noDataError) )
            }
            
        }
        task.resume()
    }
    
}


