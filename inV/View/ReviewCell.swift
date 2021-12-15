//
//  SwiftUIView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI

struct ReviewCell: View {
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("Gregg Trimarchi")
                            .padding(.bottom, 1.0)
                        HStack{
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Text("5.0")
                        }
                    }
                    .padding(.leading)
                    Spacer()
                    Text("12/12/21")
                        .padding(.trailing)
                }
                .padding([.top, .bottom, .trailing], 6.0)
                Text("This is a Review of a product that I have in person it is a very good product that I think everyone should have so definitely buy it")
                    .padding(.bottom)
            }
        }.preferredColorScheme(.dark)
        .background(Color(red: 18/255, green: 18/255, blue: 18/255))
        .frame(width: 350.0, height: 155.0)
        .border(Color(red: 18/255, green: 18/255, blue: 18/255), width: 9)
        .cornerRadius(10)
        
    }
}

struct ReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCell()
    }
}
