//
//  MainPageView.swift
//  FluxStore
//
//  Created by Berker Saptas on 18.09.2023.
//

import SwiftUI

struct MainPageView: View {
    
    
 

    @State var selectedSideMenuTab = 0

    
    init(){
        let appearance: UITabBarAppearance = UITabBarAppearance()
        UITabBar.appearance().scrollEdgeAppearance = appearance
        //   UITabBar.appearance().backgroundColor = .red
    }
    
        
    var body: some View {
        ZStack {
            Color.clrBg.ignoresSafeArea()
            TabView(selection: $selectedSideMenuTab) {
                NavigationStack {
                    HomePageView().toolbar {
                        ToolbarItem(placement: .principal, content: {
                            HStack {
                                Button{
                                    print("abc")
                                } label: {
                                    Image(Icons.hamburgerMenu.rawValue)
                                }
                                Spacer()
                                Text("GemStore").font(.headline)
                                Spacer()
                                Button{
                                    print("abc")
                                } label: {
                                    Image(systemName: "bell")
                                }
                            }
                        })
                    }
                }
                .tag(0)
                .tabItem {
                    Image(systemName: "house")
                }
                NavigationStack {
                    Color.red
                }
                .tag(1)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                NavigationStack {
                    Color.blue
                }
                .tag(2)
                .tabItem {
                    Image(systemName: "handbag")
                }
                NavigationStack {
                    Color.indigo
                }
                .tag(3)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
            }
            .accentColor(.primary)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
