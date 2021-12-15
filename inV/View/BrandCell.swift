//
//  BrandCell.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI

struct BrandCell: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("Trimarchi")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            Text("Trimarchi")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                
        }
    }
}

struct BrandCell_Previews: PreviewProvider {
    static var previews: some View {
        BrandCell().preferredColorScheme(.dark)
    }
}
