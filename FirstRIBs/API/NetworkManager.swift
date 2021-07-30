//
//  NetworkManager.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/28.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<APIService> { get }

    func getYellowFlowers(query: [String : Any], completion: @escaping (Result<YellowFlower, Error>) -> ())
    func getBlueFlowers(query: [String : Any], completion: @escaping (Result<BlueFlower, Error>) -> ())
}

class NetworkManager: Networkable {
    
    // 기본
    var provider = MoyaProvider<APIService>()
    // 네크워크 로그 볼 수 있게
//    var provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])

    func getYellowFlowers(query: [String : Any], completion: @escaping (Result<YellowFlower, Error>) -> ()) {
        request(target: .yellowFlowers(query: query), completion: completion)
    }
    
    func getBlueFlowers(query: [String : Any], completion: @escaping (Result<BlueFlower, Error>) -> ()) {
        request(target: .blueFlowers(query: query), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: APIService, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
