//
//  Service.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//

import Foundation
import Alamofire


class Service {
    
    static let shared = Service()
    
    public func requestProducts(completion: @escaping (Result<ProductsList, Error>) -> Void){
        
        let urlString = Constants.baseApi + Endpoints.products + "xx" //To simulate response error
        
        AF.request(urlString).responseDecodable(of: ProductsList.self) { response in
            switch response.result {
            case .success(_):
                do {
                    if let responseData = response.data {
                        let results = try JSONDecoder().decode(ProductsList.self, from: responseData)
                        completion(.success(results))
                    } else {
                        let error = NSError()
                        completion(.failure(error))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

