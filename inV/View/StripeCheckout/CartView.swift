//
//  CartView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI
import Stripe

struct CartView: View {
    
    @ObservedObject var auth = AuthViewModel()
    
    @State var isFetchingPaymentIntent: Bool = false
    @State var isCartEmpty: Bool = false
    @State var productIsTapped: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            VStack(alignment: .center, spacing: 0.0){
                    HStack(alignment: .top){
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.green)
                            .padding(.all)
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                        Spacer()
                        Text("Cart")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding(.top, 8.0)
                            .foregroundColor(.white)
                        Spacer()
                        Text("")
                            .padding(.trailing, 50.0)
                    }
                if !auth.isAuthenticated {
                    Spacer()
                    Text("Please create an account or sign in")
                    NavigationLink(destination: MainView()){
                        Button("Create Account/Sign in"){
                            
                        }
                            .frame(width: 250.0, height: 50.0)
                            .font(.title3)
                            .foregroundColor(.black)
                            .background(inVGreen)
                            .cornerRadius(25)
                            .shadow(color: inVGreen, radius: 3, x: 0.0, y: 0.0)
                            .padding(.all)
                    }
                }else if auth.user.cart.isEmpty{
                    Spacer()
                    Image(systemName: "cart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150.0, height: 150.0)
                        .foregroundColor(inVGreen)
                        .shadow(color: inVGreen, radius: 2, x: -1.0, y: 2.0)
                    Text("There is nothing in your cart right now.")
                        .padding(.all)
                }else if auth.isLoading{
                    
                    ProgressView()
                    
                }else if auth.errorMessage != nil{
                    
                    Text("Oops! Something went wrong!")
                    Text("Please Try Again").underline()
                        .onTapGesture {
                                auth.getCart()
                        }
                }else {
                        ScrollView{
                            LazyVGrid(columns: [GridItem(.flexible())]){
                                ForEach(auth.Products, id: \.id){ product in
                                    ProductInCart(auth: auth, product: product)
                                        .padding(.vertical, 3.0)
                                        .onTapGesture{
                                            productIsTapped.toggle()
                                            
                                        }
                                    
                                    if productIsTapped{
                                        
                                        Button("Remove from cart"){
                                            auth.removeCart(productId: product.id)
                                            productIsTapped.toggle()
                                        }
                                            .foregroundColor(.red)
                                            .frame(width: 360.0, height: 50)
                                    } else { /* do nothing */ }
                                }
                            }
                        }
                        HStack{
                            Text("Subtotal: ")
                                .font(.title2)
                                .foregroundColor(.white)
                            Text("$150.00")
                                .font(.title2)
                                .foregroundColor(inVGreen)
                        }
                        .padding(.all)
                        
                    NavigationLink(destination: FinalizeOrderView(auth: auth)){
                            
                            Text("Finalize Order")
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .onAppear{
                if !auth.user.cart.isEmpty && auth.isAuthenticated{
                    auth.getCart()
                }
                
            }
    }
}



struct ProductInCart: View {
    
    let auth: AuthViewModel
    let product: ProductModel
    
    var body: some View {
        ZStack{
            HStack{
                Image("Prada linea img")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                    .padding([.top, .leading, .bottom], 8.0)
                VStack(alignment: .leading){
                    Text(product.productName)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                    Text("\(product.price)")
                        .foregroundColor(inVGreen)
                        
                }
                .padding(.vertical, 1.0)
                VStack(){
                    HStack(){
                        Image(systemName: "minus.circle").foregroundColor(.red)
                            .onTapGesture {
                                auth.minusQuantityToItem(productId: product.id)
                            }
                        Text("\(auth.getQuantity(productId: product.id))").foregroundColor(.white)
                        Image(systemName: "plus.circle.fill").foregroundColor(inVGreen)
                            .onTapGesture {
                                auth.addQuantityToItem(productId: product.id)
                            }
                    }
                    .padding(.all, 2.0)
                    Text("\(auth.getColowayName(productId: product.id))")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        
                        
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
        NavigationView {
            CartView()
        }
    }
}
