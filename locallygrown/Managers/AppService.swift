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
        loggedUser = UserDefaults.standard.structData(Shopper.self, forKey: "loggedUser")

        //MARK: user initilization for testing UserDefaults
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
