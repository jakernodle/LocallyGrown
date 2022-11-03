//
//  shopperAPIClient.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

class ShopperAPIClient {
    func signup(params: [String: String], completion: @escaping (Result<Shopper, RemoteApiError>) -> Void) {
        
    }
    func addFarmToFavorites(params: [String: String], completion: @escaping (Result<String, RemoteApiError>) -> Void) {
        
    }
    func getFarms(params: [String: String], completion: @escaping (Result<FarmList, RemoteApiError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("recieved response from getFarms after async delay")
            completion(.success(Constants.farmListResponse.toFarmList()))
        })
    }
    func getFarm(params: [String: String], completion: @escaping (Result<Farm, RemoteApiError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("recieved response from getFarm after async delay")
            completion(.success(Constants.farmResponse.toFarm()))
        })
    }
    //I decided that saving carts to the db isnt of top importance at the moment, local should be fine for now
    /*func addItemToCart(params: [String: String], completion: @escaping (Result<ShoppingCartItem, RemoteApiError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("recieved response from addItemToCart after async delay")
            completion(.success(Constants.shoppingCartItemResponse.toShoppingCartItem()))
        })
    }*/
}
