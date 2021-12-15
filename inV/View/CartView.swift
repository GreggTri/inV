//
//  CartView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI

struct CartView: View {
    @State var isCartEmpty: Bool = false
    
    var body: some View {
        VStack(alignment: .center){
            HStack(alignment: .top){
                Image(systemName: "arrow.backward")
                    .foregroundColor(.green)
                    .padding(.all)
                Spacer()
                Text("Cart")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8.0)
                Spacer()
                Text("")
                    .padding(.trailing, 50.0)
            }
            if(isCartEmpty){
                Spacer()
                Image(systemName: "cart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150.0, height: 150.0)
                    .foregroundColor(inVGreen)
                    .shadow(color: inVGreen, radius: 2, x: -1.0, y: 2.0)
                Text("There is nothing in your cart right now.")
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
            }else{
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible())]){
                        ForEach(1...2, id: \.self){ i in
                            ProductInCart()
                                .padding(.vertical, 3.0)
                        }
                    }
                }
                HStack{
                    Text("Subtotal: ")
                        .font(.title2)
                    Text("$150.00")
                        .font(.title2)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Button("Checkout"){
                    print("User would like to checkout")
                }
                .frame(width: 300.0, height: 50.0)
                .font(.title3)
                .foregroundColor(.black)
                .background(inVGreen)
                .cornerRadius(25)
                .shadow(color: inVGreen, radius: 3, x: 0.0, y: 0.0)
                .padding(.bottom)
            }
            Spacer()
        }.preferredColorScheme(.dark)
    }
}


struct ProductInCart: View {
    var body: some View {
        ZStack{
            HStack{
                Image("Prada linea img")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                    .padding([.top, .leading, .bottom], 8.0)
                VStack(alignment: .leading){
                    Text("Prada Linea Series")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                    Text("$75")
                        .foregroundColor(inVGreen)
                        
                }
                .padding(.vertical, 1.0)
                VStack(){
                    HStack(){
                        Image(systemName: "minus.circle").foregroundColor(.red)
                        Text("1")
                        Image(systemName: "plus.circle.fill").foregroundColor(inVGreen)
                    }
                    .padding(/*@START_MENU_TOKEN@*/.all, 2.0/*@END_MENU_TOKEN@*/)
                    Text("Olive Green")
                        .font(.subheadline)
                        .fontWeight(.light)
                        
                        
                }
                .padding(.trailing, 5.0)
            }
        }
        .background(Color(red: 18/255, green: 18/255, blue: 18/255))
        .frame(width: 360.0, height: 105.0)
        .cornerRadius(10)
    }
}



//MARK: Preview
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
