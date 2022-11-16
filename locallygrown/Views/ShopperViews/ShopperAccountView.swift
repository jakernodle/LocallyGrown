//
//  ShopperAccountView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/21/22.
//

import SwiftUI
import Kingfisher

class ShopperAccountViewModel {
    
    var name: String
    var pictureURL: String
    
    init() {
        self.name = LocallyGrownShopper.shared.loggedUser?.name ?? "Shopper"
        self.pictureURL = LocallyGrownShopper.shared.loggedUser?.pictureURL ?? ""
    }
    
    func getUserInfo() {
        self.name = LocallyGrownShopper.shared.loggedUser?.name ?? "Shopper"
        self.pictureURL = LocallyGrownShopper.shared.loggedUser?.pictureURL ?? ""
    }
}

struct ShopperAccountView: View {
    
    var viewModel = ShopperAccountViewModel()
    @State var name: String = "Shopper"
    @State var pictureUrl: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06))
                    .ignoresSafeArea(.all)
                VStack {
                    VStack {
                        HStack {
                            Text("Hey, \(name)")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.largeTitle)
                                .padding(.top, 6)

                            Spacer()
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
                        }
                        .padding(.horizontal, 20)
                        
                        HStack {
                            VStack {
                                NavigationLink(destination: ShopperFavoritesView()) {
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
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                    }
                                    .padding(.vertical, 6)
                                    .cornerRadius(10)

                                }
                                .background(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                                .cornerRadius(10)
                                .padding([.leading, .trailing], 8)
                            }
                            VStack {
                                NavigationLink(destination: ShopperOrderView()) {
                                    VStack {
                                        Image("orders-bag")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 28)
                                            .frame(maxWidth: .infinity)
                                            .foregroundColor(.green)
                                        Text("Orders")
                                            .font(.footnote)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                    }
                                    .padding(.vertical, 6)
                                    .cornerRadius(10)
                                }
                                .background(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                                .cornerRadius(10)
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
            }
            .navigationBarTitle("Account")
            .navigationBarHidden(true)
        }
        .onAppear(){
            viewModel.getUserInfo()
            name = viewModel.name
            pictureUrl = viewModel.pictureURL
        }
    }
}

struct ShopperAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperAccountView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
