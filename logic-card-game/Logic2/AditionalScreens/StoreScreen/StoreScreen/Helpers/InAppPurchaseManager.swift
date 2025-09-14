//
//  InAppPurchaseManager.swift
//  Logic2
//
//  Created by Mikita on 23.09.24.
//

import StoreKit

enum ProductIDs {
    static let product100 = "Natallia.com.AIEvolution.EnergyBoost"
    static let product500 = "Natallia.com.AIEvolution.ModestFortune500"
    static let product1000 = "Natallia.com.AIEvolution.EmpireTreasure1000"
    static let product10000 = "Natallia.com.AIEvolution.UltimatePower10000"
}

enum InAppPurchaseResult {
    case purchased
    case failed
    case restored
}

class InAppPurchaseManager: NSObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    static let shared = InAppPurchaseManager()
    
    var closure: ((InAppPurchaseResult) -> Void)?
    
    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    // Метод для запроса продуктов
    func requestProducts(completion: @escaping ([SKProduct]) -> Void) {
        let productIdentifiers: Set<String> = [
            ProductIDs.product100,
            ProductIDs.product500,
            ProductIDs.product1000,
            ProductIDs.product10000
        ]
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
        
        // Храните completion блок для использования в методе `productsRequest(_:didReceive:)`
        self.productsRequestCompletion = completion
    }
    
    private var productsRequestCompletion: (([SKProduct]) -> Void)?
    
    // Обработка ответа от App Store
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        productsRequestCompletion?(products)
        productsRequestCompletion = nil // Очистите блок после выполнения
    }
    
    func purchase(product: SKProduct, closure: @escaping ((InAppPurchaseResult) -> Void)) {
        self.closure = closure
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                handlePurchase(transaction)
                closure?(.purchased)
            case .failed:
                handleFailed(transaction)
                closure?(.failed)
            case .restored:
                handleRestored(transaction)
                closure?(.restored)
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        // Handle removed transactions if necessary
    }
    
    func handlePurchase(_ transaction: SKPaymentTransaction) {
        // Update UI or internal state
        print("Purchase completed for product: \(transaction.payment.productIdentifier)")
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    func handleFailed(_ transaction: SKPaymentTransaction) {
        // Show error message to user
        print("Purchase failed for product: \(transaction.payment.productIdentifier)")
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    func handleRestored(_ transaction: SKPaymentTransaction) {
        // Update UI or internal state
        print("Purchase restored for product: \(transaction.payment.productIdentifier)")
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}
