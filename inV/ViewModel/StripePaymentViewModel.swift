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
    let backendCheckoutUrl = URL(string: "https://kiwi-candied-smoke.glitch.me/checkout")!  // An example backend endpoint
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?

    func preparePaymentSheet() {
        // MARK: Fetch the PaymentIntent and Customer information from the backend
        var request = URLRequest(url: backendCheckoutUrl)
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
                }
            })
        task.resume()
    }

    func onCompletion(result: PaymentSheetResult) {
        self.paymentResult = result

        // MARK: Demo cleanup
        if case .completed = result {
            // A PaymentIntent can't be reused after a successful payment. Prepare a new one for the demo.
            self.paymentSheet = nil
            //preparePaymentSheet()
        }
    }
}
