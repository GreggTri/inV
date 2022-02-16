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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let product: ProductModel
    
    @ObservedObject var auth = AuthViewModel()
    
    @State var selectedColorway: String = ""
    
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
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                    Text(product.productName)
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .padding(.top)
                                
                    Spacer()
                    if auth.user.favorites.contains(where: {$0.productId == product.id}){
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(inVGreen)
                            .padding([.top, .trailing])
                            .onTapGesture {
                                
                                auth.removeFavorites(productId: product.id)
                            }
                    } else {
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                            .padding([.top, .trailing])
                            .onTapGesture {
                                auth.addFavorites(productId: product.id)
                            }
                    }
                        
                }
                .padding(.top)
                .frame(width: UIScreen.main.bounds.width, height: 90)
                .background(Color.black.opacity(0.5))
                
                
                Spacer()
                
                VStack(spacing: 0.0){
                    HStack(alignment: .bottom, spacing: 0.0){
                        VStack(alignment: .leading){
                            Text("Color Selected: \(selectedColorway)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            HStack(){
                                ForEach(product.colorway, id: \.colorName){ colorway in
                                    RoundedRectangle(cornerRadius: 5).frame(width: 25, height: 25).foregroundColor(Color(UIColor.init(named: colorway.hexcode)!))
                                        .onTapGesture {
                                            if colorway.colorName != selectedColorway{
                                                selectedColorway = colorway.colorName
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.bottom, 4.0)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 80)
                    .background(Color.black.opacity(0.5))
                    
                    if product.countInStock == 0 {
                        HStack(alignment: .center, spacing: 0.0){
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text("Out Of Stock")
                                .font(.headline)
                                .padding(.trailing)
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 70)
                        .background(Color.red)
                        .foregroundColor(.black)
                        .onTapGesture {
                            //do nothing
                        }
                    } else {
                        HStack(alignment: .center, spacing: 0.0){
                            
                            Image(systemName: "cart.fill")
                            Text("Add To Cart")
                                .font(.headline)
                                .padding(.trailing)
                            Text("\(product.price)")
                                .padding(.leading)
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 70)
                        .background(inVGreen)
                        .foregroundColor(.black)
                        .onTapGesture {
                            if !auth.user.cart.contains(where: {$0.productId == product.id}){
                                auth.addCart(productId: product.id, colorwayName: selectedColorway)
                            }
                        }
                    }
                }
                
            }.zIndex(1)
            
            ARViewRepresentable(arDelegate: arDelegate)
            
        }.edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}



//struct ARProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARProductView()
//    }
//}
