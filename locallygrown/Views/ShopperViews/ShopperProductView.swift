//
//  ShopperProductView.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/2/22.
//

import SwiftUI
import Kingfisher

struct ShopperProductView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    var hasProductInCart: Bool
    
    var farmInfo: CartFarmInfo
    
    var product: ProductBasicInfo
    @State var amount: Float
    
    var totalPrice: Float {
        amount * product.price
    }
    var formattedPrice: String {
        String(format: "%.2f", totalPrice)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading){
                KFImage(URL(string: product.pictureURL))
                    .frame(width: 50, height: 180)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(0)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .tint(.gray)
                }
                    .padding()
            }
            
            ZStack(alignment: .bottomLeading) {
                VStack {
                    Text(product.name)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                        .padding(.top, 6)
                        .padding(.bottom, 1)
                    
                    Text("$\(product.formattedPrice)\(product.unitsDescription)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, -2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(product.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            amount -= 1
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .tint(.black)
                        }
                        Spacer()

                        TextField("\(amount)\(product.unitsDescription)", value: $amount, formatter: NumberFormatter())
                            .font(.title3)
                            .padding()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(width: 100, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.black, lineWidth: 3)
                            )
                        Spacer()

                        Button(action: {
                            amount += 1
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .tint(.black)
                        }
                        Spacer()
                    }
                    .padding(.top, 12)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .frame(maxHeight: .infinity)
                VStack {
                    if (hasProductInCart){
                        Button(action: {
                            ShopperService().removeFromCart(farmId: farmInfo.farmId, productId: product.id)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Remove from cart")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 6)
                        }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            .padding(.vertical, 8)

                    }
                    
                    Button(action: {
                        ShopperService().addToCart(farmInfo: farmInfo, productId: product.id, item: ShoppingCartItem(productInfo: product, unitsInCart: amount))
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(hasProductInCart ? "Update cart - $\(formattedPrice)": "Add to cart - $\(formattedPrice)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 6)
                    }
                        .buttonStyle(.borderedProminent)
                        .tint(.black)
                        .padding(.vertical, 8)
                }
                .padding(.horizontal, 20)
            }//z
        }//v
    }//bod
}

struct ShopperProductView_Previews: PreviewProvider {
    static var previews: some View {
        
        let prod = ProductBasicInfo(id: "1", name: "Preview test", description: "blah blah blah", price: 4.99, pictureURL: "https://foodtank.com/wp-content/uploads/2020/04/COVID-19-Relief_Small-Farms-.jpg", unitsDescription: "")
        ShopperProductView(hasProductInCart: true, farmInfo: CartFarmInfo(farmId: "1", farmName: "Poopy Test Name", farmAddress: "1926 west lake drive, burlington nc", farmImageURL: "https://foodtank.com/wp-content/uploads/2020/04/COVID-19-Relief_Small-Farms-.jpg"), product: prod, amount: 3)
    }
}
