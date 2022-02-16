//
//  StripePaymentViewModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/15/21.
//

import Foundation
import Stripe

class MyBackendModel: ObservableObject {
    //DELETE NSAPPTRANSPORTSECURITY IN plist WHEN SWITCHING TO live
    let checkoutUrl = URL(string: "https://kiwi-candied-smoke.glitch.me/checkout")!
    
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    @Published var user: UserModel!
    var paymentId: String = ""

    func preparePaymentSheet() {
        // MARK: Fetch the PaymentIntent and Customer information from the backend
        var request = URLRequest(url: checkoutUrl)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        as? [String: Any],
                    let paymentIntentClientSecret = json["paymentIntent"] as? String,
                    let publishableKey = json["publishableKey"] as? String
                else {
                    // Handle error
                    return
                }
                // MARK: Set your Stripe publishable key - this allows the SDK to make requests to Stripe for your account
                STPAPIClient.shared.publishableKey = publishableKey

                // MARK: Create a PaymentSheet instance
                var configuration = PaymentSheet.Configuration()
                configuration.merchantDisplayName = "inV"
                configuration.style = .alwaysDark
                // Set allowsDelayedPaymentMethods to true if your business can handle payment methods that complete payment after a delay, like SEPA Debit and Sofort.
                //configuration.allowsDelayedPaymentMethods = true
                
                DispatchQueue.main.async {
                    self.paymentSheet = PaymentSheet(
                        paymentIntentClientSecret: paymentIntentClientSecret,
                        configuration: configuration)
                    
                    self.paymentId = paymentIntentClientSecret
                }
                
            })
        task.resume()
    }

    func onCompletion(result: PaymentSheetResult) {
        self.paymentResult = result
        
        if case .completed = result {
            
            createOrder(paymentId: paymentId)
            self.paymentSheet = nil
        }
    }
    
    func createOrder(paymentId: String){
        
        let createOrderURL = URL(string: "http://\(preURL):5000/order/create-order")!
        let body: [String: Any] = ["userId": user.id, "cart": user.cart, "address": user.shippingInfo!, "paymentId": paymentId, "trackingId": "", "status": ""]
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        
        var request = URLRequest(url: createOrderURL)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.createOrder(request: request){[unowned self] result in
            
            DispatchQueue.main.async {
                
                switch result {
                case .failure(let error):
                    
                    print(error)
                case .success(let response):
                    self.user.cart.removeAll()
                    objectWillChange.send()
                    print(response)
                }
            }
        }
    }
}
