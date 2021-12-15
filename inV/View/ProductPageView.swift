//
//  ProductPageView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI
import SceneKit

struct ProductPageView: View {
    var body: some View {
        ScrollView(.vertical){
            VStack(){
                HStack(alignment: .top){
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.green)
                        .padding([.top, .leading], 6.0)
                    Spacer()
                    Text("Prada Linea Series")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Image(systemName: "heart")
                        .foregroundColor(.white)
                        .padding([.top, .trailing], 6.0)
                }
                .padding(/*@START_MENU_TOKEN@*/.all, 8.0/*@END_MENU_TOKEN@*/)
                HStack{
                    Text("Prada Linea Series")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("$75.00")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(inVGreen)
                }
                .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
                HStack{
                    Text("Sold By:")
                        .fontWeight(.semibold)
                    Text("Prada")
                        .underline()
                        .foregroundColor(.blue)
                    Spacer()
                    Text("Free Shipping")
                        .font(.subheadline)
                        .fontWeight(.light)
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                ProductSceneView()
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
                    ViewInARBtn()
                    Spacer()
                }
                .padding(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading) {
                    Text("Concerns greatest margaret him absolute entrance nay. Door neat week do find past he. Be no surprise he honoured indulged. Unpacked endeavor six steepest had husbands her. Painted no or affixed it so civilly. Exposed neither pressed so cottage as proceed at offices. Nay they gone sir game four.")
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
    }
}


//MARK: ProductSceneView
struct ProductSceneView: View{
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
struct ProductPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPageView()
    }
}
