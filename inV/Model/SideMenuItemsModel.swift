//
//  SideMenuItemsModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/13/21.
//

import Foundation

struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let imageName: String
    let handler: () -> Void = {
        print("Tapped a SideMenu Button ")
    }
}
