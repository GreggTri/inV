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
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
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
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                ProductSceneView(product: product)
                VStack(alignment: .leading) {
                    HStack(){
                        Text("Colors: ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            
                        Text("Olive Green")
                            .font(.callout)
                    }
                    .padding(.leading)
                    HStack{
                        ForEach(1...2, id: \.self){ i in
                            RoundedRectangle(cornerRadius: 5).frame(width: 30, height: 30).foregroundColor(Color.yellow)
                            RoundedRectangle(cornerRadius: 5).frame(width: 30, height: 30).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        Spacer()
                    }
                    .padding(.leading)
                }
                .padding(.horizontal, 40.0)
                
                HStack(alignment: .center){
                    Spacer()
                    AddtoCartBtn()
                    Spacer()
                    NavigationLink(destination: ARProductView(product: product)) {
                        ViewInARBtn()
                    }
                    Spacer()
                }
                .padding(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading) {
                    Text("\(product.desc)")
                        .font(.body)
                        .fontWeight(.light)
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                }
                VStack{
                    HStack{
                        Text("Customer Reviews")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("(5)")
                            .font(.headline)
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.yellow)
                        Text("5.0")
                            .font(.title2)
                        Text("Average Rating")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                        Spacer()
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible())]){
                        ForEach(1...5, id: \.self){ i in
                            ReviewCell()
                        }
                    }
                }
                .padding([.top, .leading, .trailing])
                
                    
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




//MARK: Preview
//struct ProductPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductPageView()
//    }
//}
