//
//  TabView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/21/22.
//

import SwiftUI

struct MainView: View {
    
    init() {
        
        let appearance = UITabBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.04)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance

    }
    
    var body: some View {
        TabView {
            ShopperHomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ShopperCartView()
                .tabItem {
                    Label("Carts", systemImage: "cart")
                }
            ShopperAccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
        .accentColor(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
