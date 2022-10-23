//
//  ShopperAccountView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/21/22.
//

import SwiftUI
import Kingfisher

struct ShopperAccountView: View {
    
    @State var showOrderView = false
    @State var showFavoritesView = false

    var body: some View {
        ZStack {
            Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06))
                .ignoresSafeArea(.all)
            VStack {
                VStack {
                    HStack {
                        Text("Hey, JohnAnge")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.largeTitle)
                        Spacer()
                        KFImage(URL(string: "https://pbs.twimg.com/profile_images/895157268811046914/VHx01Y-N_400x400.jpg")!)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke(.gray, lineWidth: 2)
                            }
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        VStack {
                            Button(action: {
                                showFavoritesView.toggle()
                            }){
                                VStack {
                                    Image("favorites-heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 28)
                                        .frame(maxWidth: .infinity)
                                        .tint(.green)
                                        .foregroundColor(.pink)
                                    Text("Favorites")
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                            .padding([.leading, .trailing], 8)
                        }
                        VStack {
                            Button(action: {
                                showOrderView.toggle()
                            }){
                                VStack {
                                    Image("orders-bag")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 28)
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(.green)
                                    Text("Orders")
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                            .padding([.leading, .trailing], 8)
                        }
                    }
                    .padding(.horizontal, 12)
                }
                .padding(.bottom, 16)
                .background(.white)
                
                List{
                    HStack {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.black)
                        Text(" Settings")
                    }
                    .listRowSeparator(.hidden)
                    .padding(.top, 10)
                    
                    HStack {
                        Image(systemName: "creditcard.fill")
                            .foregroundColor(.black)
                        Text("Payment")
                    }
                    .listRowSeparator(.hidden)
                    .padding(.top, 10)
                    
                    HStack {
                        Image(systemName: "message.fill")
                            .foregroundColor(.black)
                        Text("Submit Feedback")
                    }
                    .listRowSeparator(.hidden)
                    .padding(.top, 10)
                    
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                            .foregroundColor(.black)
                        Text("Logout")
                    }
                    .listRowSeparator(.hidden)
                    .padding(.top, 10)
                }
                .listStyle(PlainListStyle())
                .frame(maxHeight: .infinity)
                .background(.white)
            }
            .sheet(isPresented: $showOrderView) {
                ShopperOrderView()
            }
        }
    }
}

struct ShopperAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperAccountView()
    }
}
