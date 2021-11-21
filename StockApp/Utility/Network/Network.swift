//
//  NetworkLayer.swift
//  StockApp
//
//  Created by Nalin Porwal on 16/11/21.
//

import Foundation
import Combine

class Network {
    
    enum NetworkingError: LocalizedError,Error {
        
        case badURLResponse(url: URL)
        case decodeError(error: String)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured"
            case .decodeError(error: let error):
                return "[🔥] Data Can not convert Discription: \(error)"
            
            }
        }
    }
    
    
    static func downloadWithDecoder<DataModel:Codable>(_ url: URL,_ model: DataModel.Type) -> AnyPublisher<DataModel,Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLResponse($0,url)})
            .decode(type: model.self, decoder: JSONDecoder())
            .mapError({_ in NetworkingError.badURLResponse(url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static private func handleURLResponse(_ output: URLSession.DataTaskPublisher.Output,_ url: URL) throws -> Data {
         guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
            throw NetworkingError.badURLResponse(url: url)
         }
         return output.data
     }
    
}
