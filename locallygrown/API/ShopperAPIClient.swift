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
    
    func updateFavorites(params: [String: Set<FarmId>], completion: @escaping (Result<[FarmId], RemoteApiError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            completion(.success(Array(params["favorites"]!)))
        })
    }
    
    func removeFarmFromFavorites(params: [String: FarmId], completion: @escaping (Result<FarmId, RemoteApiError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            completion(.success(params["farmId"]!))
        })
    }
    
    func getFarms(params: [String: Any], completion: @escaping (Result<FarmList, RemoteApiError>) -> Void) {
        //check if for home list or favorites list
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
    
    func getFarmPickupOptions(params: [String: String], completion: @escaping (Result<PickupOptions, RemoteApiError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("recieved response from getFarmPickupOptions after async delay")
            completion(.success(Constants.options))
        })
    }
    
    func addPaymentOption(params: [String: Any], completion: @escaping (Result<CreditCard, RemoteApiError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("recieved response from addPaymentOption")
            completion(.success(Constants.creditCard))
        })
    }
    //Saving carts to the db isnt of top importance at the moment, local should be fine for now
    /*func addItemToCart(params: [String: String], completion: @escaping (Result<ShoppingCartItem, RemoteApiError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("recieved response from addItemToCart after async delay")
            completion(.success(Constants.shoppingCartItemResponse.toShoppingCartItem()))
        })
    }*/
}
