//
//  Service.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//

import Foundation
import UIKit
import Alamofire

//MARK: Protocol
protocol ProductServiceProtocol {
    func fethAllPosts(url:String,onSuccess: @escaping ([ProductsModel]) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Get Datas
struct ProductsDataService: ProductServiceProtocol {
    func fethAllPosts(url: String, onSuccess: @escaping ([ProductsModel]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of:[ProductsModel].self) { (response) in
            guard let items =  response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}
