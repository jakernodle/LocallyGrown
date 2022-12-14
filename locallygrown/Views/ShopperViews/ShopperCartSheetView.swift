//
//  ShopperCartSheetView.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/11/22.
//

import SwiftUI
import Kingfisher

struct ShopperCartSheetView: View {
    @Environment (\.presentationMode) var presentationMode

    var viewModel = ShopperAccountViewModel()
    @State var name: String = "Shopper"
    @State var pictureUrl: String = ""
    @State var cart: Cart
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack(alignment: .topLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .tint(.black)
                    }
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    
                    Text(cart.farmInfo.farmName)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                        .frame(maxWidth:.infinity, alignment: .center)
                }
                
                Divider()
                    .frame(maxHeight:2)
                
                List {
                    Section(header:
                        HStack {
                            if let url = URL(string: pictureUrl){
                                KFImage(url)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle().stroke(.gray, lineWidth: 2)
                                    }
                            }else{
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle().stroke(.gray, lineWidth: 2)
                                    }
                            }
                            Text("\(name)'s Items")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title3)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 6)
                    ) {
                        ForEach(Array(cart.items.keys), id: \.self) { key in
                            VStack {
                                HStack {
                                    Text("\(cart.items[key]!.formattedUnitsInCart)\(cart.items[key]!.productInfo.unitsDescription)")
                                    Text("\(cart.items[key]!.productInfo.name)")
                                    Spacer()
                                    Text("$\(cart.items[key]!.formattedPrice)")
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                   
                    Button(action: {
                        
                    }) {
                        HStack {
                            Image(systemName: "person.fill.badge.plus")
                                .tint(.white)
                            Text("Invite")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 6)
                        }
                        .frame(maxWidth: .infinity)
                    }
                        .buttonStyle(.borderedProminent)
                        .tint(.black)
                        .padding(.vertical, 8)
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())

                
                HStack {
                    Text("Subtotal")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("$\(cart.formattedTotalPrice)")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 20)
                
                Divider()
                    .frame(maxHeight:2)
                
                NavigationLink(destination: ShopperCheckoutView(viewModel: ShopperCheckoutViewModel(address: cart.farmInfo.farmAddress, farmId: cart.farmInfo.farmId), cart: cart)) {
                    Text("Go to checkout")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
            }
            .onAppear(){
                viewModel.getUserInfo()
                name = viewModel.name
                pictureUrl = viewModel.pictureURL
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .accentColor(.black)
    }
}

struct ShopperCartSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let testCart = Cart(farmInfo: CartFarmInfo(farmId: "1", farmName: "Test", farmAddress: "1926 west lake drive, burlington NC", farmImageURL: "https://foodtank.com/wp-content/uploads/2020/04/COVID-19-Relief_Small-Farms-.jpg"), items: ["1" : ShoppingCartItem(productInfo: ProductBasicInfo(id: "1", name: "Carrots", description: "", price: 2.00, pictureURL: "", unitsDescription: "/lb"), unitsInCart: 2)])
        ShopperCartSheetView(cart: testCart)
    }
}
