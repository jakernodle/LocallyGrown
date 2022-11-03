//
//  UserService.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum UserServiceResponseCode: Error {
    //login
    case loginSuccess
    case loginFailed
    
    //signup
    case signupSuccess
    case signupFailed
    
    //favorite
    case addFarmToFavoritesSuccess
    case addFarmToFavoritesFailed
}

class UserService {
    let userApiClient = UserAPIClient()

    func logout() {
        LocallyGrown.app.logout()
    }
    
    //save picture to bucket and get url
    
    func login(params: [String: String], completion: @escaping (UserServiceResponseCode) -> Void){
        userApiClient.login(credentials: params) { result in
            switch result {
            case .success(let response):
                if let shopper = response as? Shopper {
                    LocallyGrownShopper.shared.login(user: shopper)
                }else if let supplier = response as? Supplier {
                    LocallyGrownSupplier.shared.login(user: supplier)
                }else{
                    print("error: response is neither a Shopper or a Supplier")
                }
                completion(UserServiceResponseCode.loginSuccess)
            case .failure:
                completion(UserServiceResponseCode.loginFailed)
            }
        }
    }
}

class SupplierService: UserService {
    let supplierApiClient = SupplierAPIClient()
    
    //create supplier account
    func supplierSignUp(params: [String: String], completion: @escaping (UserServiceResponseCode) -> Void){
        supplierApiClient.signup(credentials: params) { result in
            switch result {
            case .success(let response):
                LocallyGrownSupplier.shared.login(user: response)
                completion(UserServiceResponseCode.signupSuccess)
            case .failure:
                completion(UserServiceResponseCode.signupFailed)
            }
        }
    }
    //create farm
    //view products
    //add products
    //get orders
    //fullfill order
    //deny order
}

class ShopperService: UserService {
    let shopperApiClient = ShopperAPIClient()
    
    //create shopper account
    func shopperSignUp(params: [String: String], completion: @escaping (UserServiceResponseCode) -> Void) {
        shopperApiClient.signup(params: params) { result in
            switch result {
            case .success(let response):
                LocallyGrownShopper.shared.login(user: response)
                completion(UserServiceResponseCode.signupSuccess)
            case .failure:
                completion(UserServiceResponseCode.signupFailed)
            }
        }
    }
    //view all farms
    func getFarms(params: [String: String], completion: @escaping (Result<[ShopperHomeViewFarmListViewObject], UserServiceResponseCode>) -> Void) {
        shopperApiClient.getFarms(params: params) { result in
            switch result {
            case .success(let response):
                completion(.success(response.farms))
            case .failure:
                completion(.failure(UserServiceResponseCode.signupFailed))
            }
        }
    }
    
    //view farm with id
    func getFarm(params: [String: String], completion: @escaping (Result<ShopperFarmViewFarm, UserServiceResponseCode>) -> Void) {
        shopperApiClient.getFarm(params: params) { result in
            switch result {
            case .success(let response):
                completion(.success(response.toShopperFarmViewFarm()))
            case .failure:
                completion(.failure(UserServiceResponseCode.signupFailed))
            }
        }
    }
    
    //addProductToCart -> save it locally
    func addToCart(farmId: FarmId, farmName: String, item: ShoppingCartItem){
        LocallyGrownShopper.shared.addItemToCart(farmId: farmId, farmName: farmName, item: item)
    }
    
    //createOrder
    //editOrder
    //addFarmToFavorites
    func addFarmToFavorites(farmId: String, completion: @escaping (UserServiceResponseCode) -> Void){
        shopperApiClient.addFarmToFavorites(params: ["id": farmId]) { result in
            switch result {
            case .success(let response):
                LocallyGrownShopper.shared.addFarmToFavorites(farmId: response)
                completion(UserServiceResponseCode.addFarmToFavoritesSuccess)
            case .failure:
                completion(UserServiceResponseCode.addFarmToFavoritesFailed)
            }
        }
    }
}
