//
//  APIClient.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import Combine

enum APIVerion: URLConvertible {
    
    private static let baseURL = "https://gorest.co.in/public/"
    
    case v1(endpoint: String)
    case v2(endpoint: String)
    
    func asURL() throws -> URL {
        switch self {
        case .v1(let endpoint):
            let urlString = "\(APIVerion.baseURL)v1\(endpoint)"
            guard let url = URL(string: urlString) else {
                throw AFError.invalidURL(url: urlString)
            }
            return url
        case .v2(let endpoint):
            let urlString = "\(APIVerion.baseURL)v2\(endpoint)"
            guard let url = URL(string: urlString) else {
                throw AFError.invalidURL(url: urlString)
            }
            return url
        }
    }
}

class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    private func request<T>(endpoint: APIVerion,
                            method: HTTPMethod,
                            params: Parameters? = nil,
                            encoding: ParameterEncoding = JSONEncoding.default,
                            headers: HTTPHeaders? = nil, completion: @escaping (JSON) -> T) -> AnyPublisher<T, Error> {
        return AF.request(endpoint,
                          method: method,
                          parameters: params,
                          encoding: encoding,
                          headers: headers).publishData().tryMap { response -> T in
            let json = try! JSON(data: response.data!)
            return completion(json)
        }.eraseToAnyPublisher()
    }
}

extension APIClient {
    func GET<T>(endpoint: APIVerion, params: Parameters? = nil, completion: @escaping(JSON) -> T) -> AnyPublisher<T, Error> {
        request(endpoint: endpoint, method: .get, params: params ,encoding: URLEncoding.default , completion: completion)
    }
}
