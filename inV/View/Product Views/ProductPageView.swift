//
//  ProductPageView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI
import SceneKit

struct ProductPageView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let product: ProductModel
    @ObservedObject var auth = AuthViewModel()
    @ObservedObject var productFetcher = ProductFetcher()
    
    @State private var revealReviews = false
    @State var selectedColorway: String = ""
    var body: some View {
        ScrollView(.vertical){
            VStack(){
                HStack(alignment: .top){
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(inVGreen)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                    Text("\(product.productName)")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Spacer()
                    if auth.user.favorites.contains(where: {$0.productId == product.id}){
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(inVGreen)
                            .onTapGesture {
                                
                                auth.removeFavorites(productId: product.id)
                            }
                    } else {
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                            .onTapGesture {
                                auth.addFavorites(productId: product.id)
                            }
                    }
                }
                .padding(.all, 8.0)
                HStack{
                    Text("\(product.productName)")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(product.price)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(inVGreen)
                }
                .padding([.top, .leading, .trailing])
                HStack{
                    Text("Sold By:")
                        .fontWeight(.semibold)
                    NavigationLink(destination: BrandShopView(brand: product.seller)){
                        Text("\(product.seller.brandName)")
                            .underline()
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Text("Free Shipping")
                        .font(.subheadline)
                        .fontWeight(.light)
                }
                .padding(.horizontal)
                ProductSceneView(product: product)
                VStack(alignment: .leading) {
                    HStack(){
                        Text("Color Selected: ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            
                        Text("\(selectedColorway)")
                            .font(.callout)
                    }
                    .padding(.leading)
                    HStack{
                        ForEach(product.colorway, id: \.colorName){ colorway in
                            RoundedRectangle(cornerRadius: 5).frame(width: 25, height: 25).foregroundColor(Color(UIColor.init(named: colorway.hexcode)!))
                                .onTapGesture {
                                    if colorway.colorName != selectedColorway{
                                        selectedColorway = colorway.colorName
                                    }
                                }
                        }
                        Spacer()
                    }
                    .padding(.leading)
                }
                .padding(.horizontal, 40.0)
                
                HStack(alignment: .center){
                    Spacer()
                    if product.countInStock == 0 {
                        OutOfStockBtn()
                    }
                    AddtoCartBtn()
                        .onTapGesture {
                            if !auth.user.cart.contains(where: {$0.productId == product.id}){
                                auth.addCart(productId: product.id, colorwayName: selectedColorway)
                            }
                        }
                    Spacer()
                    NavigationLink(destination: ARProductView(product: product)) {
                        ViewInARBtn()
                    }
                    Spacer()
                }
                .padding(.vertical)
                VStack(alignment: .leading) {
                    Text("\(product.desc)")
                        .font(.body)
                        .fontWeight(.light)
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                }
                VStack(){
                    HStack(){
                        DisclosureGroup("Customer Reviews", isExpanded: $revealReviews){
                            
                            if revealReviews {
                                let _ = productFetcher.fetchReviews(productId: product.id)
                            }
                            
                            if productFetcher.isLoading{
                                ProgressView()
                            } else if productFetcher.errorMessage != nil{
                                Text("Could not load Reviews, Sorry!")
                                Text("Please try again...").underline()
                                    .onTapGesture{
                                        productFetcher.fetchReviews(productId: product.id)
                                    }
                            } else {
                                VStack(){
                                    Text("\(productFetcher.Reviews.count) Reviews")
                                    HStack{
                                        Text("Average Rating: ")
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.yellow)
                                        Text("\(product.avgRating)")
                                    }
                                    LazyVGrid(columns: [GridItem(.flexible())]){
                                        ForEach(productFetcher.Reviews, id: \.id){ review in
                                            ReviewCell(review: review)
                                            //add review parameter to this
                                        }
                                    }
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
                }
//                VStack{
//                    HStack{
//                        Text("Customer Reviews")
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                        Text("(5)")
//                            .font(.headline)
//                        Spacer()
//                    }
//                    HStack {
//                        Image(systemName: "star.fill")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 25, height: 25)
//                            .foregroundColor(.yellow)
//                        Text("5.0")
//                            .font(.title2)
//                        Text("Average Rating")
//                            .font(.footnote)
//                            .foregroundColor(Color.gray)
//                        Spacer()
//                    }
//
//                    LazyVGrid(columns: [GridItem(.flexible())]){
//                        ForEach(1...5, id: \.self){ i in
//                            ReviewCell()
//                        }
//                    }
//                }
//                .padding([.top, .leading, .trailing])
                
                    
            }
        }.preferredColorScheme(.dark)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
    }
}


//MARK: ProductSceneView
struct ProductSceneView: View{
    
    let product: ProductModel
    
    var body: some View{
        
        SceneView(
            scene: {
                //would put product.colorway.model here but somehow make sure that the model used is the same as the selectedColorway var
                let scene = SCNScene(named: "testsunglasses.usdz")!
                scene.background.contents = UIColor.black//(Color(red: 18/255, green: 18/255, blue: 18/255))
                return scene
            }(),
            options: [.autoenablesDefaultLighting, .allowsCameraControl]
        )
        .frame(width: 380, height: 300)
        .cornerRadius(25)
    }
}

//MARK: ViewInAR Button
struct ViewInARBtn: View{
    
    var body: some View{
        ZStack{
            HStack{
                Image("ViewInARIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Text("View In AR")
                Image(systemName: "chevron.right")
            }
        }
        .frame(width: 180.0, height: 50.0)
        .font(.headline)
        .foregroundColor(.black)
        .background(inVGreen)
        .cornerRadius(25)
        .shadow(color: inVGreen, radius: 3, x: 0.0, y: 0.0)
    }
}
//MARK: AddtoCart Button
struct AddtoCartBtn: View{
    
    var body: some View{
        ZStack{
            HStack{
                Image(systemName: "cart.fill")
                Text("Add To Cart")
            }.zIndex(1.0)
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(inVGreen, lineWidth: 3)
                .shadow(color: inVGreen, radius: 1, x: 0.0, y: 0.0)
            
        }
        .frame(width: 180.0, height: 50.0)
        .font(.headline)
        .foregroundColor(inVGreen)
        
    }
}

//MARK: OutOfStockBtn Button
struct OutOfStockBtn: View{
    
    var body: some View{
        ZStack{
            HStack{
                Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.red)
                Text("Out of stock").foregroundColor(.red)
            }.zIndex(1.0)
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(.red, lineWidth: 3)
                .shadow(color: .red, radius: 1, x: 0.0, y: 0.0)
            
        }
        .frame(width: 180.0, height: 50.0)
        .font(.headline)
        .foregroundColor(inVGreen)
        
    }
}




//MARK: Preview
struct ProductPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPageView(product: ProductModel.example1())
    }
}
