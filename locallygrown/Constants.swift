//
//  Constants.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/26/22.
//

import Foundation

class Constants {
    
    static let product1 = Product(id: "1",name: "Carrot",description: "These delicious carrots are grown without any hericides or pesticides and taste great in a stew!", pictureURL: "https://hips.hearstapps.com/ghk.h-cdn.co/assets/18/09/2048x1364/gallery-1519672422-carrots.jpg?resize=1200:*", category: ProductCategory.produce(id: "produce"), pricing: Pricing(cost: 2.00, units: UnitType.perLb), isOffered: true)
    
    static let product2 = Product(id: "2",name: "Lettuce",description: "This lettuce is a creamy buttery and crunchy.", pictureURL: "https://www.bhg.com/thmb/7vrGQSuzaBhr1B96c6kHxoiYP-E=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/static.onecms.io__wp-content__uploads__sites__37__2020__04__17__tango-oakleaf-lettuce-c6f6417e-93a9e0262454403e982e4e78d38bbb39.jpg", category: ProductCategory.produce(id: "produce"), pricing: Pricing(cost: 2.00, units: UnitType.perLb), isOffered: true)
    
    static let shoppingCartItemResponse = ShoppingCartItemResponse(productInfo: product1.toProductBasicInfo(), unitsInCart: 2)
    
    static let item = ShoppingCartItem(productInfo: product1.toProductBasicInfo(), unitsInCart: 2)
    static let item2 = ShoppingCartItem(productInfo: product2.toProductBasicInfo(), unitsInCart: 3)
    
    static let farmerInfo = FarmSupplierInfo(id: "1", name: "Steve", pictureURL: "https://otbsalessolutions.com/wp-content/uploads/2021/08/Farmer-standing-in-field.jpg")
    
    static let farmResponse = FarmResponse(id: "1", name: "Happy Farms", pictureURL: "https://foodtank.com/wp-content/uploads/2020/04/COVID-19-Relief_Small-Farms-.jpg", about: "Happy Farms came from a small town in a small area with good strong corn stalks and lots of guys with overals and trucker hats", address: "1926 west lake drive, Burlington NC, 27215", reviews: [FarmReview(userId: "1", userName: "JohnAnge", ratingOutOfFive: 5, reviewText: "I love this place.")], averageRating: 5, products: [product1, product2], farmerInfo: [farmerInfo], paymentInfo: nil)
    
    static let farmList = [ShopperHomeViewFarmListViewObject(farmId: "1", name: "Poopy Farms", pictureURL: "https://foodtank.com/wp-content/uploads/2020/04/COVID-19-Relief_Small-Farms-.jpg", suppliers: [farmerInfo], categories: "Produce, Meat")]
    
    static let farmListResponse = FarmListResponse(farms: farmList)
    
    static let pastorder1 = Order(id: "1", shopperId: "1", farmId: "1", sharedShoppers: [], shoppingCart: [item, item2], orderType: OrderType.pickup(id: "pickup"), completed: true)
    
    static let currentorder1 = Order(id: "2", shopperId: "1", farmId: "1", sharedShoppers: [], shoppingCart: [item, item2], orderType: OrderType.pickup(id: "pickup"), completed: false)
    
    //static let pastcart1 = Cart(items: [item, item2], farmName: "Poopy Farms", itemsAmount: <#T##String#>, totalPrice: <#T##Float#>)
    
    static let testUser1: Shopper = Shopper(id: "1", name: "JohnAnge", email: "jakernodle@gmail.com", pictureURL: "https://lh3.googleusercontent.com/ogw/AOh-ky1qBybrjK8keXF0hmuO98ueuCLOq34eEpR-S0Enbvs=s32-c-mo", favoriteFarmIds: [], paymentInfo: nil, orders: [], carts: [:])
    
}
