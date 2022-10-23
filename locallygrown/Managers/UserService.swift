//
//  UserService.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum UserServiceResponse: Error {
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
    
    func login(params: [String: String], completion: @escaping (UserServiceResponse) -> Void){
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
                completion(UserServiceResponse.loginSuccess)
            case .failure:
                completion(UserServiceResponse.loginFailed)
            }
        }
    }
}

class SupplierService: UserService {
    let supplierApiClient = SupplierAPIClient()
    
    //create supplier account
    func supplierSignUp(params: [String: String], completion: @escaping (UserServiceResponse) -> Void){
        supplierApiClient.signup(credentials: params) { result in
            switch result {
            case .success(let response):
                LocallyGrownSupplier.shared.login(user: response)
                completion(UserServiceResponse.signupSuccess)
            case .failure:
                completion(UserServiceResponse.signupFailed)
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
    func shopperSignUp(params: [String: String], completion: @escaping (UserServiceResponse) -> Void) {
        shopperApiClient.signup(params: params) { result in
            switch result {
            case .success(let response):
                LocallyGrownShopper.shared.login(user: response)
                completion(UserServiceResponse.signupSuccess)
            case .failure:
                completion(UserServiceResponse.signupFailed)
            }
        }
    }
    //view suppliers
    //createOrder
    //editOrder
    //addFarmToFavorites
    func addFarmToFavorites(farmId: String, completion: @escaping (UserServiceResponse) -> Void){
        shopperApiClient.addFarmToFavorites(params: ["id": farmId]) { result in
            switch result {
            case .success(let response):
                LocallyGrownShopper.shared.loggedUser?.favoriteFarmIds.append(response)
                completion(UserServiceResponse.addFarmToFavoritesSuccess)
            case .failure:
                completion(UserServiceResponse.addFarmToFavoritesFailed)
            }
        }
    }
}
