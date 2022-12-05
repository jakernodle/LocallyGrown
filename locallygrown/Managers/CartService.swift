//
//  CartService.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/22/22.
//

import Foundation

// CartService.swift is currently an extension of LocallyGrownShopper as the cart is controlled by loggedUser(defined in LocallyGrownShopper), which is an object of type Shopper
// the cart service will become its own class once cart is abstracted from the Shopper and accessed using it's id
extension LocallyGrownShopper {
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
}
