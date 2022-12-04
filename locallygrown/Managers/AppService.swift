//
//  App.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum UserType: Int {
    case none = 0
    case shopper = 1
    case supplier = 2
}

class LocallyGrown {
    
    static let app = LocallyGrown()
    
    var loggedUserType: UserType? {
        didSet {
            UserDefaults.standard.set(loggedUserType?.rawValue, forKey: "userType")
        }
    }
    
    var isLoggedIn: Bool { loggedUserType != UserType.none }
    
    func logout() {
        loggedUserType = nil
    }
    
}

class LocallyGrownShopper: LocallyGrown {
    
    static let shared = LocallyGrownShopper()
    
    var loggedUser: Shopper? {
        didSet {
            if loggedUser != nil {
                loggedUserType = UserType.shopper
            }
            UserDefaults.standard.setStruct(loggedUser, forKey: "loggedUser")
        }
    }
    
    func login(user: Shopper){
        loggedUser = user
    }
    
    func addCardToAccount(card: CreditCard){
        if loggedUser?.paymentInfo.cards.count == 0 {
            loggedUser?.paymentInfo.selectedCard = card
        }
        loggedUser?.paymentInfo.cards.append(card)
    }
    
    func setSelectedCard(card: CreditCard){
        loggedUser?.paymentInfo.selectedCard = card
    }
    
    func removeCard(index: Int){
        if loggedUser?.paymentInfo.selectedCard?.id == loggedUser?.paymentInfo.cards[index].id {
            loggedUser?.paymentInfo.selectedCard = nil
        }
        loggedUser?.paymentInfo.cards.remove(at: index)
    }
    
    func addItemToCart(farmInfo: CartFarmInfo, productId: ProductId, item: ShoppingCartItem){
        if(loggedUser?.carts[farmInfo.farmId] != nil){
            loggedUser?.carts[farmInfo.farmId]!.items[productId] = item
        }else{
            let cart = Cart(farmInfo: farmInfo, items: [productId:item])
            loggedUser?.carts[farmInfo.farmId] = cart
        }
    }
    
    func removeItemFromCart(farmId: FarmId, productId: ProductId){
        loggedUser?.carts[farmId]!.items[productId] = nil
    }
    
    func getCarts() -> [FarmId:Cart] {
        return loggedUser?.carts ?? [:]
    }
    
    func cleanCart(farmId: FarmId){
        if loggedUser?.carts[farmId]?.items.count == 0 {
            loggedUser?.carts.removeValue(forKey: farmId)
        }
    }
    
    func removeCart(farmId: FarmId){
        loggedUser?.carts.removeValue(forKey: farmId)
    }
    
    func getItemsInCart(cartId: FarmId) -> [ProductId:ShoppingCartItem]? {
        return loggedUser?.carts[cartId]?.items
    }
    
    func formattedUnitsOfProductInCart(cartId: FarmId, productId: ProductId) -> String? {
        guard let cart = loggedUser?.carts[cartId] else { return nil } //TODO: throw cart doesnt exist error
        guard let product = cart.items[productId] else { return nil }
        
        //here we use the .clean Float extension to remove any trailing ".0's"
        return product.unitsInCart.clean
    }
    
    func getCartSize(cartId: FarmId) -> Int {
        return (loggedUser?.carts[cartId]?.items.count ?? 0)
    }
    
    func hasLikedFarmForId(farmId: FarmId) -> Bool{
        guard let ids = loggedUser?.favoriteFarmIds else { return false }
        return ids.contains(farmId)
    }
    
    func addFarmToFavorites(farmId: FarmId){
        loggedUser?.favoriteFarmIds.insert(farmId)
    }
    
    func removeFarmFromFavorites(farmId: FarmId){
        loggedUser?.favoriteFarmIds.remove(farmId)
    }
    
    func getFavorites() -> Set<FarmId> {
        loggedUser?.favoriteFarmIds ?? Set<FarmId>()
    }
    
    private override init() {
        super.init()
        loggedUserType = UserType(rawValue: UserDefaults.standard.integer(forKey: "userType"))
        print("type")
        print(loggedUserType)
        loggedUser = UserDefaults.standard.structData(Shopper.self, forKey: "loggedUser")
        print("type")
        print(loggedUserType)
        print("loggedUser")
        print(loggedUser)
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
