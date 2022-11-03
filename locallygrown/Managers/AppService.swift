//
//  App.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum UserType: Int {
    case shopper = 0
    case supplier = 1
}

class LocallyGrown {
    
    static let app = LocallyGrown()
    
    var loggedUserType: UserType? {
        didSet {
            UserDefaults.standard.set(loggedUserType?.rawValue, forKey: "userType")
        }
    }
    
    var isLoggedIn: Bool { loggedUserType != nil }
    
    func logout() {
        loggedUserType = nil
    }
    
}

class LocallyGrownShopper: LocallyGrown {
    
    static let shared = LocallyGrownShopper()
    
    var loggedUser: Shopper? {
        didSet {
            loggedUserType = UserType.shopper
            UserDefaults.standard.setStruct(loggedUser, forKey: "loggedUser")
        }
    }
    
    func login(user: Shopper){
        loggedUser = user
    }
    
    func addItemToCart(farmId: FarmId, farmName: String, item: ShoppingCartItem){
        if(loggedUser?.carts?[farmId] != nil){
            loggedUser?.carts?[farmId]!.items.append(item)
        }else{
            let cart = Cart(farmName: farmName, items: [item])
            loggedUser?.carts?[farmId] = cart
        }
    }
    
    func hasItemForCart(cartId: FarmId) -> Bool {
        return loggedUser?.carts?[cartId] != nil
    }
    
    func getCartSize(cartId: FarmId) -> Int {
        return (loggedUser?.carts?[cartId]?.items.count ?? 0)
    }
    
    func addFarmToFavorites(farmId: FarmId){
        loggedUser?.favoriteFarmIds.append(farmId)
    }
    
    private override init() {
        super.init()
        loggedUserType = UserType(rawValue: UserDefaults.standard.integer(forKey: "userType"))
        loggedUser = UserDefaults.standard.structData(Shopper.self, forKey: "loggedUser")
        
        //MARK: initilization for testing
        //loggedUserType = UserType.shopper
        //loggedUser = Constants.testUser1
    }
}

class LocallyGrownSupplier: LocallyGrown {
    
    static let shared = LocallyGrownSupplier()
    
    var loggedUser: Supplier? {
        didSet {
            loggedUserType = UserType.supplier
            UserDefaults.standard.setStruct(loggedUser, forKey: "loggedUser")
        }
    }
    
    func login(user: Supplier){
        loggedUser = user
    }

    private override init() {
        super.init()
        loggedUserType = UserDefaults.standard.value(forKey: "userType") as? UserType
        loggedUser = UserDefaults.standard.structData(Supplier.self, forKey: "loggedUser")
    }
}
