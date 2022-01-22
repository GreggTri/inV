//
//  CheckoutView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/15/21.
//

import Stripe
import SwiftUI

struct FinalizeOrderView: View {
    @ObservedObject var model = MyBackendModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            HStack(alignment: .top){
                Image(systemName: "arrow.backward")
                    .foregroundColor(.green)
                    .padding(.all)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                Text("Your Order")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8.0)
                    .foregroundColor(.white)
                Spacer()
                Text("")
                    .padding(.trailing, 50.0)
            }
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible())]){
                    ForEach(1...2, id: \.self){ i in
                        FinalizedOrder()
                            .padding(.vertical, 3.0)
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
        
            if let paymentSheet = model.paymentSheet {
                PaymentSheet.PaymentButton(
                    paymentSheet: paymentSheet,
                    onCompletion: model.onCompletion
                ) {
                   CheckoutButton()
                }
            } else {
                LoadingView()
            }
            if let result = model.paymentResult {
                PaymentStatusView(result: result)
            }
        }.onAppear { model.preparePaymentSheet() }
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct CheckoutButton: View {
    var body: some View {
        Button("Checkout"){
            print("User would like to checkout")
            
        }.accessibility(identifier: "Buy button")
        .frame(width: 300.0, height: 50.0)
        .font(.title3)
        .foregroundColor(.black)
        .background(inVGreen)
        .cornerRadius(25)
        .shadow(color: inVGreen, radius: 3, x: 0.0, y: 0.0)
        .padding(.bottom)
    }
}

struct LoadingView: View {
    var body: some View {
        if #available(iOS 14.0, *) {
            ProgressView()
        } else {
            Text("Preparing payment…")
        }
    }
}

struct PaymentStatusView: View {
    let result: PaymentSheetResult

    var body: some View {
        HStack {
            switch result {
            case .completed:
                Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                Text("Your order is confirmed!")
            case .failed(let error):
                Image(systemName: "xmark.octagon.fill").foregroundColor(.red)
                Text("Payment failed: \(error.localizedDescription)")
            case .canceled:
                Image(systemName: "xmark.octagon.fill").foregroundColor(.orange)
                Text("Payment canceled.")
            }
        }
        .accessibility(identifier: "Payment status view")
    }
}

struct ExamplePaymentOptionView: View {
    let paymentOptionDisplayData: PaymentSheet.FlowController.PaymentOptionDisplayData?

    var body: some View {
        HStack {
            Image(uiImage: paymentOptionDisplayData?.image ?? UIImage(systemName: "creditcard")!)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 30, maxHeight: 30, alignment: .leading)
                .foregroundColor(.black)
            Text(paymentOptionDisplayData?.label ?? "Select a payment method")
                // Surprisingly, setting the accessibility identifier on the HStack causes the identifier to be
                // "Payment method-Payment method". We'll set it on a single View instead.
                .accessibility(identifier: "Payment method")
        }
        .frame(minWidth: 200)
        .padding()
        .foregroundColor(.black)
        .background(Color.init(white: 0.9))
        .cornerRadius(6)
    }
}

struct FinalizedOrder: View {
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
                        .padding(.bottom)
                    Text("$75")
                        .foregroundColor(inVGreen)
                        .padding(.bottom, 3.0)
                        
                }
                .padding(.vertical, 1.0)
                VStack(){
                    HStack(){
                        Text("Quantity: ").font(.subheadline).foregroundColor(.white)
                        Text("1").font(.subheadline).foregroundColor(inVGreen)
                    }
                    .padding(.all, 3.0)
                    Text("Olive Green")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        
                        
                }
                .padding(.trailing, 5.0)
                .padding(.top, 27.0)
            }
        }
        .background(Color(red: 18/255, green: 18/255, blue: 18/255))
        .frame(width: 360.0, height: 105.0)
        .cornerRadius(10)
    }
}

struct ExampleSwiftUIPaymentSheet_Preview: PreviewProvider {
    static var previews: some View {
        FinalizeOrderView()
    }
}
