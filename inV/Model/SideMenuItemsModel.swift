//
//  SideMenuItemsModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/13/21.
//

import Foundation
import SwiftUI

enum MenuItem: Int, CaseIterable {
    case myCart
    case favorites
    case orders
    case shippinginfo
    case accountinfo
    case signin
    case createaccount
    
    var title: String {
        switch self {
        case .myCart: return "My Cart"
        case .favorites: return "Favorites"
        case .orders: return "My Orders"
        case .shippinginfo: return "Shipping Info"
        case .accountinfo: return "Account Info"
        case .signin: return "Sign In"
        case .createaccount: return "Create Account"
        }
    }
    
    var imageName: String {
        switch self {
        case .myCart: return "cart.fill"
        case .favorites: return "heart.fill"
        case .orders: return "bag.fill"
        case .shippinginfo: return "house.fill"
        case .accountinfo: return "person"
        case .signin: return "person"
        case .createaccount: return "person"
        }
    }
    
    @ViewBuilder var handler: some View {
        
            switch self {
            case .myCart: CartView()
            case .favorites: FavoritesView()
            case .orders: OrdersView()
            case .shippinginfo: ShippingInfoView()
            case .accountinfo: AccountView()
            case .signin: MainView()
            case .createaccount: MainView()
            }
    }
}

extension MenuItem {
    static let authCases: [MenuItem] = [.myCart, .favorites, .orders, .shippinginfo, .accountinfo]
    static let nonAuthedCases: [MenuItem] = [.signin, .createaccount]
}
