//
//  UserService.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum UserServiceResponseCode: Error {
    case loginSuccess
    case loginFailed
    case signupSuccess
    case signupFailed
    case getFarmsFailed
    case getFarmSuccess
    case getFarmPickUpOptionFailed
    case getFarmPickUpOptionSucceeded
    case addFarmToFavoritesSuccess
    case addFarmToFavoritesFailed
    case removeFarmFromFavoritesSuccess
    case removeFarmFromFavoritesFailed
}

class UserService {
    let userApiClient = UserAPIClient()

    func logout() {
        LocallyGrown.app.logout()
    }
        
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

class ShopperService: UserService {
    let shopperApiClient = ShopperAPIClient()
    
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
    
    func getFarms(params: [String: Any], completion: @escaping (Result<[ShopperHomeViewFarmListViewObject], UserServiceResponseCode>) -> Void) {
        shopperApiClient.getFarms(params: params) { result in
            switch result {
            case .success(let response):
                completion(.success(response.farms))
            case .failure:
                completion(.failure(UserServiceResponseCode.signupFailed))
            }
        }
    }
    
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
    
    func getFarmPickupOptions(params: [String: String], completion: @escaping (Result<PickupOptions, UserServiceResponseCode>) -> Void) {
        shopperApiClient.getFarmPickupOptions(params: params) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure:
                completion(.failure(UserServiceResponseCode.getFarmPickUpOptionFailed))
            }
        }
    }
    
    //TODO: get farm reviews
    
    //add card to account
    func addPaymentOption(params: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        shopperApiClient.addPaymentOption(params: params) { result in
            switch result {
            case .success(let response):
                LocallyGrownShopper.shared.addCardToAccount(card: response)
                print(LocallyGrownShopper.shared.loggedUser?.paymentInfo)
                completion(.success(()))
            case .failure:
                completion(.failure(UserServiceResponseCode.signupFailed))
            }
        }
    }
    
    //TODO: func createOrder
    
    func addToCart(farmInfo: CartFarmInfo, productId: ProductId, item: ShoppingCartItem){
        LocallyGrownShopper.shared.addItemToCart(farmInfo: farmInfo, productId: productId, item: item)
    }
    
    func removeFromCart(farmId: FarmId, productId: ProductId){
        LocallyGrownShopper.shared.removeItemFromCart(farmId: farmId, productId: productId)
    }
    
    // Both addToFavorites and removeFromFavorites add farms to the local then update the user in the cloud.
    // These are updated locally and not with a response object since immediate changes to the UI trump data consistency in this case
    func addToFavorites(farmId: FarmId){
        LocallyGrownShopper.shared.addFarmToFavorites(farmId: farmId)
        updateFavorites()
    }
    
    func removeFromFavorites(farmId: FarmId){
        LocallyGrownShopper.shared.removeFarmFromFavorites(farmId: farmId)
        updateFavorites()
    }
    
    func updateFavorites(){
        let favorites = LocallyGrownShopper.shared.getFavorites()
        
        shopperApiClient.updateFavorites(params: ["favorites": favorites]) { result in
            switch result {
            case .success(let response):
                print(response)
                break
            case .failure:
                print("failed to update user favorites in backend") //TODO: idk do something
            }
        }
    }
}

class SupplierService: UserService {
    let supplierApiClient = SupplierAPIClient()
    
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
