//
//  ShopperOrderView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/22/22.
//

import SwiftUI
import Kingfisher

struct ShopperOrderView: View {
    
    @State private var carts: [ShopperOrderViewModel] = [ShopperOrderViewModel(farmName: "Happy Farms", productsNumber: 2, totalPrice: 13.99, date: Date()),ShopperOrderViewModel(farmName: "Happy Farms", productsNumber: 2, totalPrice: 13.99, date: Date())]
    
    var body: some View {
        VStack {
            Text("Orders")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle)
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            List{
                ForEach(carts, id: \.self) { item in
                    HStack {
                        KFImage(URL(string: "https://pbs.twimg.com/profile_images/895157268811046914/VHx01Y-N_400x400.jpg")!)
                            .frame(width: 34, height: 34)
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke(.gray, lineWidth: 2)
                            }
                            .padding(.horizontal, 6)

                        VStack(alignment: .leading) {
                            Text(item.farmName)
                                .font(.body)
                                .fontWeight(.bold)
                            
                            Text("\(item.productsNumber) items - $\(item.formattedPrice)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                            Text("\(item.formattedDate)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .padding(.top, 10)
                }
            }
            .listStyle(PlainListStyle())
            .frame(maxHeight: .infinity)
            .background(.white)
        }
    }
}

struct ShopperOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperOrderView()
    }
}
