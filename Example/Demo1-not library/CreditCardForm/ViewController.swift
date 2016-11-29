//
//  ViewController.swift
//  CreditCardForum
//
//  Created by Atakishiyev Orazdurdy on 11/5/16.
//  Copyright © 2016 Veriloft. All rights reserved.
//

import UIKit
import Stripe
import AKMaskField
import CreditCardValidator

public enum Brands : String {
    case NONE, Visa, MasterCard, Amex, JCB, DEFAULT, Discover
}

class ViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    let paymentTextField = STPPaymentCardTextField()
    var cardView: UIView!
    var backImage: UIImageView!
    var imageView: UIImageView!
    
    var cardNumber:AKMaskField!
    var cardHolder:UILabel!
    var fullname:UILabel!
    var expireDate: AKMaskField!
    var expireDateText: UILabel!
    var backView: UIView!
    var frontView: UIView!
    var backLine: UIView!
    var cvc: AKMaskField!
    var chipImg: UIImageView!
    
    var showingBack = false
    var gradientLayer: CAGradientLayer!
    
    var colors = [String : [UIColor]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colors[Brands.NONE.rawValue] = [UIColor.hexStr(hexStr: "#363434", alpha: 1), UIColor.hexStr(hexStr: "#363434", alpha: 1)]
        colors[Brands.Visa.rawValue] = [UIColor.hexStr(hexStr: "#5D8BF2", alpha: 1), UIColor.hexStr(hexStr: "#3545AE", alpha: 1)]
        colors[Brands.MasterCard.rawValue] = [UIColor.hexStr(hexStr: "#ED495A", alpha: 1), UIColor.hexStr(hexStr: "#8B1A2B", alpha: 1)]
        colors[Brands.Amex.rawValue] = [UIColor.hexStr(hexStr: "#005B9D", alpha: 1), UIColor.hexStr(hexStr: "#132972", alpha: 1)]
        colors[Brands.JCB.rawValue] = [UIColor.hexStr(hexStr: "#265797", alpha: 1), UIColor.hexStr(hexStr: "#3d6eaa", alpha: 1)]
        colors["Diners Club"] = [UIColor.hexStr(hexStr: "#5b99d8", alpha: 1), UIColor.hexStr(hexStr: "#4186CD", alpha: 1)]
        colors[Brands.Discover.rawValue] = [UIColor.hexStr(hexStr: "#e8a258", alpha: 1), UIColor.hexStr(hexStr: "#D97B16", alpha: 1)]
        colors[Brands.DEFAULT.rawValue] = [UIColor.hexStr(hexStr: "#5D8BF2", alpha: 1), UIColor.hexStr(hexStr: "#3545AE", alpha: 1)]
        
        createCard()
        
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
        
        let top = paymentTextField.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20)
        let horizontalConstraint = paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let widthConstraint = paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20)
        let heightConstraint = paymentTextField.heightAnchor.constraint(equalToConstant: 44)
        
        NSLayoutConstraint.activate([top, widthConstraint, heightConstraint, horizontalConstraint])
    }
    
    func setGradientBackground(v: UIView, top: CGColor, bottom: CGColor) {
        let colorTop =  top
        let colorBottom = bottom
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = v.bounds
        backView.backgroundColor = UIColor.hexStr(hexStr: "#363434", alpha: 1)
        v.layer.addSublayer(gradientLayer)
    }
    
    func createCard() {
        let frame = self.view.frame
        cardView = UIView(frame: CGRect(x: (frame.size.width - 300)/2, y: 64, width: 300, height: 200))
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 6
        cardView.backgroundColor = .red
        
        backView = UIView(frame: CGRect(x: (frame.size.width - 300)/2, y: 64, width: 300, height: 200))
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = 6
        backView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        backView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
        frontView = UIView(frame: CGRect(x: (frame.size.width - 300)/2, y: 64, width: 300, height: 200))
        frontView.translatesAutoresizingMaskIntoConstraints = false
        frontView.layer.cornerRadius = 6
        frontView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        frontView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
        backImage = UIImageView(frame: CGRect.zero)
        backImage.translatesAutoresizingMaskIntoConstraints = false
        backImage.image = UIImage(named: "back.jpg")
        backImage.contentMode = UIViewContentMode.scaleAspectFill
        
        //Card brand image
        imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        //Credit card number
        cardNumber = AKMaskField()
        cardNumber.translatesAutoresizingMaskIntoConstraints = false
        cardNumber.maskExpression = "{....} {....} {....} {....}"
        //cardNumber.text =  "XXXXXXXXXXXXXXXX"
        cardNumber.textColor = .white
        cardNumber.isUserInteractionEnabled = false
        cardNumber.textAlignment = NSTextAlignment.center
        cardNumber.font = UIFont(name: "Helvetica Neue", size: 20)
        
        //Card holder uilabel
        cardHolder = UILabel(frame: CGRect.zero)
        cardHolder.translatesAutoresizingMaskIntoConstraints = false
        cardHolder.font = UIFont(name: "Helvetica Neue", size: 10)
        cardHolder.text = "CARD HOLDER"
        cardHolder.textColor = UIColor.hexStr(hexStr: "#bdc3c7", alpha: 1)
        
        //Name
        fullname = UILabel(frame: CGRect.zero)
        fullname.translatesAutoresizingMaskIntoConstraints = false
        fullname.font = UIFont(name: "Helvetica Neue", size: 12)
        fullname.text = "Atakishi Oraz"
        fullname.textColor = .white
        
        //Expire Date
        expireDate = AKMaskField()
        expireDate.translatesAutoresizingMaskIntoConstraints = false
        expireDate.font = UIFont(name: "Helvetica Neue", size: 12)
        expireDate.maskExpression = "{..}/{..}"
        expireDate.text = paymentTextField.expirationPlaceholder
        expireDate.textColor = .white
        
        //Expire Date Text
        expireDateText = UILabel(frame: CGRect.zero)
        expireDateText.translatesAutoresizingMaskIntoConstraints = false
        expireDateText.font = UIFont(name: "Helvetica Neue", size: 10)
        expireDateText.text = "EXPIRY"
        expireDateText.textColor = UIColor.hexStr(hexStr: "#bdc3c7", alpha: 1)
        
        //BackLine
        backLine = UIView(frame: CGRect.zero)
        backLine.translatesAutoresizingMaskIntoConstraints = false
        backLine.backgroundColor = .black
        
        //CVC textfield
        cvc = AKMaskField()
        cvc.translatesAutoresizingMaskIntoConstraints = false
        cvc.maskExpression = "..."
        cvc.text = paymentTextField.cvc
        cvc.backgroundColor = .white
        cvc.textAlignment = NSTextAlignment.center
        cvc.isUserInteractionEnabled = false
        
        //Chip image
        chipImg = UIImageView(frame: CGRect.zero)
        chipImg.image = UIImage(named: "chip")
        chipImg.translatesAutoresizingMaskIntoConstraints = false
        chipImg.alpha = 0.5
        
        frontView.isHidden = false
        backView.isHidden = true
        
        cardView.clipsToBounds = true
        //frontView.addSubview(backImage)
        cardView.addSubview(frontView)
        
        setGradientBackground(v: frontView, top: UIColor.hexStr(hexStr: "#363434", alpha: 1).cgColor, bottom: UIColor.hexStr(hexStr: "#363434", alpha: 1).cgColor)
        
        frontView.addSubview(imageView)
        frontView.addSubview(cardHolder)
        frontView.addSubview(fullname)
        frontView.addSubview(cardNumber)
        frontView.addSubview(expireDate)
        frontView.addSubview(expireDateText)
        frontView.addSubview(chipImg)
        
        backView.addSubview(backLine)
        backView.addSubview(cvc)
        cardView.addSubview(backView)
        view.addSubview(cardView)
        
        //CardView
        let top = cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64)
        let horizontalConstraint = cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let widthConstraint = cardView.widthAnchor.constraint(equalToConstant: 300)
        let heightConstraint = cardView.heightAnchor.constraint(equalToConstant: 170)
        NSLayoutConstraint.activate([top, widthConstraint, heightConstraint, horizontalConstraint])
        
        //Back View
        let frontViewtop = frontView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64)
        let frontViewhorizontalConstraint = frontView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let frontViewwidthConstraint = frontView.widthAnchor.constraint(equalToConstant: 300)
        let frontViewheightConstraint = frontView.heightAnchor.constraint(equalToConstant: 170)
        NSLayoutConstraint.activate([frontViewtop, frontViewhorizontalConstraint, frontViewwidthConstraint, frontViewheightConstraint])
        
        //Back View
        let cardBacktop = backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64)
        let cardBackhorizontalConstraint = backView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let cardBackwidthConstraint = backView.widthAnchor.constraint(equalToConstant: 300)
        let cardBackheightConstraint = backView.heightAnchor.constraint(equalToConstant: 170)
        NSLayoutConstraint.activate([cardBacktop, cardBackhorizontalConstraint, cardBackwidthConstraint, cardBackheightConstraint])
        
        //        //Background imageview
        //        let backImgTop = backImage.topAnchor.constraint(equalTo: cardView.topAnchor)
        //        let leadingCont = backImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor)
        //        let trailingCont = backImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
        //        let bottomCont = backImage.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        //        NSLayoutConstraint.activate([backImgTop, leadingCont, trailingCont, bottomCont])
        
        //Card brand imageview
        let top1 = imageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10)
        let trailing = imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10)
        let widthConstraint1 = imageView.widthAnchor.constraint(equalToConstant: 60)
        let heightConstraint1 = imageView.heightAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([top1, trailing, widthConstraint1, heightConstraint1])
        
        //Card number
        let horizontalConstraintcardNumber = cardNumber.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
        let verticalConstraintcardNumber = cardNumber.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        let widthConstraintcardNumber = cardNumber.widthAnchor.constraint(equalToConstant: 200)
        let heightConstraintcardNumber = cardNumber.heightAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate([widthConstraintcardNumber, verticalConstraintcardNumber, heightConstraintcardNumber, horizontalConstraintcardNumber])
        
        //Name
        let fullnameBottom = fullname.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20)
        let fullnameleadingCont = fullname.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15)
        NSLayoutConstraint.activate([fullnameBottom, fullnameleadingCont])
        
        //Card Holder
        let cardHolderTop = cardHolder.bottomAnchor.constraint(equalTo: fullname.topAnchor, constant: -3)
        let cardHolderleadingCont = cardHolder.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15)
        NSLayoutConstraint.activate([cardHolderTop, cardHolderleadingCont])
        
        //Expire Date
        let expireDateBottom = expireDate.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20)
        let expireDateleadingCont = expireDate.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -55)
        NSLayoutConstraint.activate([expireDateBottom, expireDateleadingCont])
        
        //Expire Date Text
        let expireDateTextBottom = expireDateText.bottomAnchor.constraint(equalTo: expireDate.topAnchor, constant: -3)
        let expireDateTextLeadingCont = expireDateText.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -58)
        NSLayoutConstraint.activate([expireDateTextBottom, expireDateTextLeadingCont])
        
        let chipImgtop = chipImg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15)
        let chipImgtrailing = chipImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15)
        let chipImgwidthConstraint = chipImg.widthAnchor.constraint(equalToConstant: 45)
        let chipImgheightConstraint = chipImg.heightAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate([chipImgtop, chipImgtrailing, chipImgwidthConstraint, chipImgheightConstraint])
        
        //Back Line
        let backLinetop = backLine.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20)
        let backLinehorizontalConstraint = backLine.centerXAnchor.constraint(equalTo: backView.centerXAnchor)
        let backLinewidthConstraint = backLine.widthAnchor.constraint(equalToConstant: 300)
        let backLineheightConstraint = backLine.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([backLinetop, backLinehorizontalConstraint, backLinewidthConstraint, backLineheightConstraint])
        
        //cvc
        let cvcTop = cvc.topAnchor.constraint(equalTo: backLine.bottomAnchor, constant: 10)
        let cvcwidthConstraint = cvc.widthAnchor.constraint(equalToConstant: 50)
        let cvcheightConstraint = cvc.heightAnchor.constraint(equalToConstant: 25)
        let trailingCVC = cvc.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10)
        NSLayoutConstraint.activate([cvcTop, cvcwidthConstraint, cvcheightConstraint, trailingCVC])
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        self.cardNumber.text = textField.cardNumber
        
        self.expireDate.text = NSString(format: "%02ld", textField.expirationMonth) as String + "/" + (NSString(format: "%02ld", textField.expirationYear) as String)
        
        if textField.expirationMonth == 0 {
            expireDate.text = "MM/YY"
        }
        let v = CreditCardValidator()
        self.cvc.text = textField.cvc
        
        if (textField.cardNumber?.characters.count)! >= 7 || (textField.cardNumber?.characters.count)! < 4 {
            
            guard let type = v.type(from: "\(textField.cardNumber!)") else {
                self.imageView.image = nil
                if let name = colors["NONE"] {
                    setType(colors: [name[0].cgColor, name[1].cgColor], alpha: 0.5, back: name[0])
                }
                return
            }
            
            // Visa, Mastercard, Amex etc.
            if let name = colors[type.name] {
                self.imageView.image = UIImage(named: type.name)
                setType(colors: [name[0].cgColor, name[1].cgColor], alpha: 1, back: name[0])
            }else{
                setType(colors: [self.colors["DEFAULT"]![0].cgColor, self.colors["DEFAULT"]![0].cgColor], alpha: 1, back: self.colors["DEFAULT"]![0])
            }
        }
    }
    
    func setType(colors: [CGColor], alpha: CGFloat, back: UIColor) {
        UIView.animate(withDuration: 2, animations: { () -> Void in
            self.gradientLayer.colors = colors
        })
        self.backView.backgroundColor = back
        self.chipImg.alpha = alpha
    }
    
    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        
        if "\(textField.expirationYear)".characters.count <= 1 {
            expireDate.text = "MM/YY"
        }
    }
    
    func paymentCardTextFieldDidBeginEditingExpiration(_ textField: STPPaymentCardTextField) {
        
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        if !showingBack {
            flip()
            showingBack = true
        }
    }
    
    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        if showingBack {
            flip()
            showingBack = false
        }
    }
    
    func flip() {
        var showingSide = frontView
        var hiddenSide = backView
        if showingBack {
            (showingSide, hiddenSide) = (backView, frontView)
        }
        
        UIView.transition(from:showingSide!,
                          to: hiddenSide!,
                          duration: 0.7,
                          options: [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews],
                          completion: nil)
        
    }
    
}

extension UIColor {
    class func hexStr ( hexStr : NSString, alpha : CGFloat) -> UIColor {
        let hexStr = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string", terminator: "")
            return UIColor.white;
        }
    }
}

