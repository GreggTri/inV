//
//  ARProductView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/13/21.
//

import SwiftUI
import ARKit
import SceneKit

struct ARProductView: View {
    @ObservedObject var arDelegate = ARDelegate()
    
    var body: some View {
        ZStack{
            VStack(spacing: 0.0){
                HStack(alignment: .top, spacing: 0.0){
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                        .foregroundColor(.green)
                        .padding([.top, .leading])
                        .padding(.top, 3.0)
                    Spacer()
                    Text("Prada Linea Series")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .padding(.top)
                                
                    Spacer()
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                        .foregroundColor(.white)
                        .padding([.top, .trailing])
                }
                .padding(.top)
                .frame(width: UIScreen.main.bounds.width, height: 90)
                .background(Color.black.opacity(0.5))
                
                
                Spacer()
                
                VStack(spacing: 0.0){
                    HStack(alignment: .bottom, spacing: 0.0){
                        VStack(alignment: .leading){
                            Text("Color Selected: " + "Olive Green")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            HStack(){
                                ForEach(1...2, id: \.self){ i in
                                    RoundedRectangle(cornerRadius: 5).frame(width: 25, height: 25).foregroundColor(Color.yellow)
                                    RoundedRectangle(cornerRadius: 5).frame(width: 25, height: 25).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                }
                            }
                        }
                        .padding(.bottom, 4.0)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 80)
                    .background(Color.black.opacity(0.5))
                    
                    HStack(alignment: .center, spacing: 0.0){
                        
                        
                        
                        Image(systemName: "cart.fill")
                        Text("Add To Cart")
                            .font(.headline)
                            .padding(.trailing)
                        Text("$75.00")
                            .padding(.leading)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 70)
                    .background(inVGreen)
                    .foregroundColor(.black)
                    .onTapGesture {
                        print("User Wants to add this Item to cart")
                    }
                }
                
            }.zIndex(1)
            
            ARViewRepresentable(arDelegate: arDelegate)
            
        }.edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
    }
}




struct ARProductView_Previews: PreviewProvider {
    static var previews: some View {
        ARProductView()
    }
}
