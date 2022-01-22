//
//  BrandCell.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI

struct BrandCell: View {
    let brand: SellerModel
    
    var body: some View {
        VStack(alignment: .center) {
            Image("Trimarchi")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            Text(brand.brandName)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                
        }
    }
}
