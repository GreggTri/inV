//
//  MainView.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/27/22.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var auth = AuthViewModel()
    
    var body: some View {
        if !auth.isAuthenticated {
            AuthView(auth: auth)
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }else {
            HomeView(auth: auth)
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
