//
//  PPView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/13/21.
//

import SwiftUI

struct PPView: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundColor(inVGreen)
                Spacer()
                Text("Privacy Policy")
                    .font(.title2)
                Spacer()
                Text("")
            }
            
            Spacer()
        }.preferredColorScheme(.dark)
    }
}



//MARK: Preview Our PP
struct PPView_Previews: PreviewProvider {
    static var previews: some View {
        PPView()
    }
}
