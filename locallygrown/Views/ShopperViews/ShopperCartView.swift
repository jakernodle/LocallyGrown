//
//  ShopperCartView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/22/22.
//

import SwiftUI
import Kingfisher

struct ShopperCartView: View {
    @State var showCartView: Bool = false
    @State private var carts: [Cart] = []
    
    var body: some View {
        VStack {
            Text("Carts")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle)
                .padding(.horizontal, 20)
                .padding(.top, 6)
            
            List{
                ForEach(carts, id: \.self) { cart in
                    Button(action: {
                        showCartView.toggle()
                    }) {
                        HStack {
                            KFImage(URL(string: "https://pbs.twimg.com/profile_images/895157268811046914/VHx01Y-N_400x400.jpg")!)
                                .frame(width: 34, height: 34)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(.gray, lineWidth: 2)
                                }
                                .padding(.horizontal, 6)

                            VStack(alignment: .leading) {
                                Text(cart.farmInfo.farmName)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                
                                Text("\(cart.itemsAmount) items - $\(cart.formattedTotalPrice)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.top, 10)
                    }
                    .listRowSeparator(.hidden)
                    .sheet(isPresented: $showCartView) {
                        ShopperCartSheetView(cart: cart)
                    }
                }
                    .onDelete(perform: delete)
            }
            .listStyle(PlainListStyle())
            .frame(maxHeight: .infinity)
            .background(.white)
        }
        .onAppear {
            carts = ShopperCartViewModel().getCarts()
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.sorted(by: > ).forEach { (i) in
            ShopperCartViewModel().deleteCart(farmId: carts[i].farmInfo.farmId)
            carts.remove(at: i)
        }
    }
}

struct ShopperCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperCartView()
    }
}
