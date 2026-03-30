//
//  TabViews.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 05/03/2026.
//
import SwiftUI

public struct TabViews: View {
    
    @State internal var selectedTab: Int = 0
    
    public init() { }
    public var body: some View {

        TabView(selection: $selectedTab) {
            
            Tab(value: 0) {
                PageView()
            } label: {
                Image(systemName: "house")
            }
            Tab(value: 1) {
                SearchView()
            } label: {
                Image(systemName: "magnifyingglass")
            }
            Tab(value: 2) {
                BookmarkView()
            } label: {
                #if os(Android)
                Image(systemName: "person")
                #endif
                
                #if !os(Android)
                Image(systemName: "bookmark")
                #endif
            }
            Tab(value: 3) {
                AccountView()
            } label: {
                Image(systemName: "person")
                    .renderingMode(.template)
            }
        }.tint(.indigo)
     

    }
}

//#Preview {
//    TabViews()
//}
