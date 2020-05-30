//
//  ViewController.swift
//  Demo
//
//  Created by Atakishiyev Orazdurdy on 11/29/16.
//  Copyright © 2016 Veriloft. All rights reserved.
//

import UIKit
import Stripe
import CreditCardForm

class ViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    @IBOutlet weak var creditCardView: CreditCardFormView!
    let paymentTextField = STPPaymentCardTextField()
    private var cardHolderNameTextField: TextField!
    private var cardParams: STPPaymentMethodCardParams!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCardView.cardHolderString = "Oraz Atakishiyev"
        creditCardView.cardGradientColors[Brands.Amex.rawValue] = [UIColor.red, UIColor.black]
        creditCardView.cardNumberFont = UIFont(name: "HelveticaNeue", size: 20)!
        creditCardView.cardPlaceholdersFont = UIFont(name: "HelveticaNeue", size: 10)!
        creditCardView.cardTextFont = UIFont(name: "HelveticaNeue", size: 12)!
        
        paymentTextField.postalCodeEntryEnabled = false
        
        createTextField()
        
        cardParams = STPPaymentMethodCardParams()
        cardParams.number = "375987654321111"
        cardParams.expMonth = 03
        cardParams.expYear = 23
        cardParams.cvc = "7997"
        self.paymentTextField.cardParams = cardParams
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // load saved card params
        creditCardView.paymentCardTextFieldDidChange(cardNumber: cardParams.number, expirationYear: cardParams!.expYear as? UInt, expirationMonth: cardParams!.expMonth as? UInt, cvc: cardParams.cvc)
    }
    
    func createTextField() {
        cardHolderNameTextField = TextField(frame: CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44))
        cardHolderNameTextField.placeholder = "CARD HOLDER"
        cardHolderNameTextField.delegate = self
        cardHolderNameTextField.translatesAutoresizingMaskIntoConstraints = false
        cardHolderNameTextField.setBottomBorder()
        cardHolderNameTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        view.addSubview(cardHolderNameTextField)
        
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
        paymentTextField.delegate = self
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true
        
        view.addSubview(paymentTextField)
        
        NSLayoutConstraint.activate([
            cardHolderNameTextField.topAnchor.constraint(equalTo: creditCardView.bottomAnchor, constant: 20),
            cardHolderNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardHolderNameTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-25),
            cardHolderNameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: cardHolderNameTextField.bottomAnchor, constant: 20),
            paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            paymentTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationMonth, cvc: textField.cvc)
    }
    
    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidBeginEditingCVC()
    }
    
    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidEndEditingCVC()
    }
}

extension ViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        creditCardView.cardHolderString = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == cardHolderNameTextField {
            textField.resignFirstResponder()
            paymentTextField.becomeFirstResponder()
        } else if textField == paymentTextField  {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension UITextField {
    
    func setBottomBorder() {
        self.borderStyle = UITextField.BorderStyle.none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
