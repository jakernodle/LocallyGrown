//
//  ShopperFarmView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/20/22.
//

import SwiftUI
import Kingfisher

struct ShopperFarmView: View {
    
    @ObservedObject var viewModel = ShopperFarmViewModel(params: [:], service: ShopperService())
    
    var farmDataFromHomeView: ShopperHomeViewFarmListViewObject
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            // Render a clear color and start the loading process
            // when the view first appears, which should make the
            // view model transition into its loading state:
            Color.clear.onAppear(perform: viewModel.load)
        case .loading:
            let cart = Cart(farmInfo: CartFarmInfo(farmId: farmDataFromHomeView.farmId, farmName: farmDataFromHomeView.name, farmAddress: "", farmImageURL: farmDataFromHomeView.pictureURL), items: [:])
            ShopperFarmViewContent(showProgressView: true, content: ShopperFarmViewFarm(id: farmDataFromHomeView.farmId, pictureURL: farmDataFromHomeView.pictureURL, name: farmDataFromHomeView.name, rating: 0, reviewsCount: 0, about: "", address: "", productCategories: [], productMap: [:], pickupOptions: PickupOptions(standardPickup: nil, marketPickups: [], localDropoffs: [])), cart: cart)
        case .failed(let error):
            //ErrorView(error: error, retryHandler: viewModel.load)
            Color.clear.onAppear(perform: viewModel.load)
            ProgressView()
            let _ = print(error)
        case .loaded(let farm):
            let cart = Cart(farmInfo: CartFarmInfo(farmId: farmDataFromHomeView.farmId, farmName: farmDataFromHomeView.name, farmAddress: farm.address, farmImageURL: farmDataFromHomeView.pictureURL), items: [:])
            ShopperFarmViewContent(showProgressView: false, content: ShopperFarmViewFarm(id: farmDataFromHomeView.farmId, pictureURL: farmDataFromHomeView.pictureURL, name: farmDataFromHomeView.name, rating: farm.rating, reviewsCount: farm.reviewsCount, about: farm.about, address: farm.address, productCategories: farm.productCategories, productMap: farm.productMap, pickupOptions: farm.pickupOptions), cart: cart)
        }
    }
}

struct ShopperFarmViewContent: View {
     
    @Environment (\.presentationMode) var presentationMode
    @State var showProductView = false
    @State var showCartView = false

    @State var numberOfItemsInCart = 0
    var showProgressView: Bool
    var content: ShopperFarmViewFarm
    @State var cart: Cart

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                ZStack(alignment: .topLeading){
                    KFImage(URL(string: content.pictureURL))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 180)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(0)
                        .overlay {
                            Rectangle().stroke(.gray, lineWidth: 2)
                        }

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .tint(.black)
                    }
                        .padding()
                }
                
                VStack {
                    Text(content.name)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                        .padding(.top, 6)
                        .padding(.bottom, 1)
                    
                    if showProgressView == false {
                        HStack {
                            Image(systemName: "star.fill")
                            Text("\(content.formattedRating) (\(content.reviewsCount) reviews)")
                                .padding(.leading, -6)
                                .padding(.bottom, -2)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(content.about)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.body)
                    }
                }
                .padding(.horizontal, 20)
                
                if showProgressView == false {
                    List {
                        ForEach(content.productCategories, id:\.self) {category in
                            Section(header:
                                Text(category)
                                    .font(.title)
                                    .foregroundColor(.black)
                            ) {
                                ForEach(content.productMap[category]!, id:\.self) {product in
                                    Button(action: {
                                        showProductView.toggle()
                                    }) {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                HStack{
                                                    Text(product.name)
                                                        .font(.headline)
                                                        .fontWeight(.semibold)
                                                        .padding(.bottom, 2)
                                                    if(cart.hasProduct(productId: product.id)){
                                                        HStack{
                                                            Text("\(cart.amountOfProductString(productId: product.id))")
                                                                .foregroundColor(.white)
                                                                .font(.footnote)
                                                                .fontWeight(.semibold)
                                                                .padding(.trailing, -6)
                                                                .padding(.leading, 2)
                                                            Image(systemName: "cart.fill")
                                                                .foregroundColor(.white)
                                                                .padding(.vertical, 4)
                                                        }
                                                        .padding(.horizontal, 3)
                                                        .background(.green)
                                                        .cornerRadius(4)
                                                    }
                                                }
                                                Text("$\(product.formattedPrice)\(product.unitsDescription)")
                                                    .font(.footnote)
                                                    .padding(.bottom, 2)
                                                Text("\(product.description)")
                                                    .font(.footnote)
                                                    .foregroundColor(.gray)
                                                    .padding(.bottom, 2)
                                            }
                                            Spacer()
                                            KFImage(URL(string: product.pictureURL))
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(0)
                                        }
                                    }
                                    .sheet(isPresented: $showProductView) {
                                        ShopperProductView(hasProductInCart: cart.hasProduct(productId: product.id), farmInfo: CartFarmInfo(farmId: content.id, farmName: content.name, farmAddress: content.address, farmImageURL: content.pictureURL), product: product, amount: cart.amountOfProductForProductView(productId: product.id))
                                            .onDisappear {
                                                numberOfItemsInCart = LocallyGrownShopper.shared.getCartSize(cartId: content.id)
                                                print("get items")
                                                if let items = LocallyGrownShopper.shared.getItemsInCart(cartId: content.id){
                                                    cart.items = items
                                                    print("get items")
                                                    print(items)

                                                }
                                            }
                                    }
                                }
                                
                            }
                            .headerProminence(.increased)
                        }
                    }
                    .listStyle(PlainListStyle())
                } else{
                    ProgressView()
                        .padding()
                    Spacer()
                }
            }//v
            if (numberOfItemsInCart > 0) {
                Button(action: {
                    showCartView.toggle()
                }) {
                    Text("View cart (\(numberOfItemsInCart))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .padding(20)
                    .sheet(isPresented: $showCartView) {
                        ShopperCartSheetView(cart: cart)
                    }
            }
            
        }//z
        .onAppear {
            numberOfItemsInCart = LocallyGrownShopper.shared.getCartSize(cartId: content.id)
            if let items = LocallyGrownShopper.shared.getItemsInCart(cartId: content.id){
                cart.items = items
            }
        }
    }//bod
}



struct ShopperFarmView_Previews: PreviewProvider {
    static var previews: some View {
        let farmData = ShopperHomeViewFarmListViewObject(farmId: "1", name: "Preview Test", pictureURL: "https://foodtank.com/wp-content/uploads/2020/04/COVID-19-Relief_Small-Farms-.jpg", suppliers: [], categories: "")
        ShopperFarmView(farmDataFromHomeView: farmData)
    }
}
