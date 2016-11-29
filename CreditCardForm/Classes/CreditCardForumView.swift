//
//  CreditCardForumView.swift
//  CreditCardForm
//
//  Created by Atakishiyev Orazdurdy on 11/28/16.
//  Copyright © 2016 Veriloft. All rights reserved.
//

import UIKit

public enum Brands : String {
    case NONE, Visa, MasterCard, Amex, JCB, DEFAULT, Discover
}

@IBDesignable
public class CreditCardForumView : UIView {
    
    fileprivate var cardView: UIView    = UIView(frame: .zero)
    fileprivate var backView: UIView    = UIView(frame: .zero)
    fileprivate var frontView: UIView   = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
    fileprivate var gradientLayer       = CAGradientLayer()
    fileprivate var showingBack:Bool    = false
    
    fileprivate var backImage: UIImageView   = UIImageView(frame: .zero)
    fileprivate var brandImageView           = UIImageView(frame: .zero)
    fileprivate var cardNumber:AKMaskField        = AKMaskField(frame: .zero)
    fileprivate var cardHolderText:UILabel   = UILabel(frame: .zero)
    fileprivate var cardHolder:UILabel       = UILabel(frame: .zero)
    fileprivate var expireDate: AKMaskField  = AKMaskField(frame: .zero)
    fileprivate var expireDateText: UILabel  = UILabel(frame: .zero)
    fileprivate var backLine: UIView         = UIView(frame: .zero)
    fileprivate var cvc: AKMaskField         = AKMaskField(frame: .zero)
    fileprivate var chipImg: UIImageView     = UIImageView(frame: .zero)
    
    public var colors = [String : [UIColor]]()
    
    @IBInspectable
    public var defaultCardColor: UIColor = UIColor.hexStr(hexStr: "363434", alpha: 1) {
        didSet {
            gradientLayer.colors = [defaultCardColor.cgColor, defaultCardColor.cgColor]
            backView.backgroundColor = defaultCardColor
        }
    }
    
    @IBInspectable
    public var cardHolderExpireDateTextColor: UIColor = UIColor.hexStr(hexStr: "#bdc3c7", alpha: 1) {
        didSet {
            cardHolderText.textColor = cardHolderExpireDateTextColor
            expireDateText.textColor = cardHolderExpireDateTextColor
        }
    }
    
    @IBInspectable
    public var cardHolderExpireDateColor: UIColor = .white {
        didSet {
            cardHolder.textColor = cardHolderExpireDateColor
            expireDate.textColor = cardHolderExpireDateColor
            cardNumber.textColor = cardHolderExpireDateColor
        }
    }
    
    @IBInspectable
    public var backLineColor: UIColor = .black {
        didSet {
            backLine.backgroundColor = backLineColor
        }
    }
    
    @IBInspectable
    public var chipImage = UIImage(named: "chip") {
        didSet {
            chipImg.image = chipImage
        }
    }
    
    @IBInspectable
    public var cardHolderString = "----" {
        didSet {
            cardHolder.text = cardHolderString
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        createViews()
    }
    
    private func createViews() {
        frontView.isHidden = false
        backView.isHidden = true
        cardView.clipsToBounds = true
        
        if colors.count < 7 {
            setBrandColors()
        }
        
        createCardView()
        createFrontView()
        createbackImage()
        createBrandImageView()
        createCardNumber()
        createCardHolder()
        createCardHolderText()
        createExpireDate()
        createExpireDateText()
        createChipImage()
        createBackView()
        createBackLine()
        createCVC()
    }
    
    private func setGradientBackground(v: UIView, top: CGColor, bottom: CGColor) {
        let colorTop =  top
        let colorBottom = bottom
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = v.bounds
        backView.backgroundColor = defaultCardColor
        v.layer.addSublayer(gradientLayer)
    }
    
    private func createCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 6
        cardView.backgroundColor = .red
        self.addSubview(cardView)
        //CardView
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.topAnchor),
            cardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cardView.widthAnchor.constraint(equalTo: self.widthAnchor),
            cardView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    private func createBackView() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = 6
        backView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        backView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        cardView.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backView.widthAnchor.constraint(equalTo: self.widthAnchor),
            backView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    private func createFrontView() {
        frontView.translatesAutoresizingMaskIntoConstraints = false
        frontView.layer.cornerRadius = 6
        frontView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        frontView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        cardView.addSubview(frontView)
        setGradientBackground(v: frontView, top: defaultCardColor.cgColor, bottom: defaultCardColor.cgColor)
        
        NSLayoutConstraint.activate([
            frontView.topAnchor.constraint(equalTo: self.topAnchor),
            frontView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            frontView.widthAnchor.constraint(equalTo: self.widthAnchor),
            frontView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    private func createbackImage() {
        backImage.translatesAutoresizingMaskIntoConstraints = false
        backImage.image = UIImage(named: "back.jpg")
        backImage.contentMode = UIViewContentMode.scaleAspectFill
        frontView.addSubview(backImage)
        
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: cardView.topAnchor),
            backImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            backImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            backImage.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
        ])
    }
    
    private func createBrandImageView() {
        //Card brand image
        brandImageView.translatesAutoresizingMaskIntoConstraints = false
        brandImageView.contentMode = UIViewContentMode.scaleAspectFit
        frontView.addSubview(brandImageView)

        NSLayoutConstraint.activate([
            brandImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            brandImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            brandImageView.widthAnchor.constraint(equalToConstant: 60),
            brandImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func createCardNumber() {
        //Credit card number
        cardNumber.translatesAutoresizingMaskIntoConstraints = false
        cardNumber.maskExpression = "{....} {....} {....} {....}"
        cardNumber.textColor = cardHolderExpireDateColor
        cardNumber.isUserInteractionEnabled = false
        cardNumber.textAlignment = NSTextAlignment.center
        cardNumber.font = UIFont(name: "Helvetica Neue", size: 20)
        frontView.addSubview(cardNumber)
        
        NSLayoutConstraint.activate([
            cardNumber.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            cardNumber.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            cardNumber.widthAnchor.constraint(equalToConstant: 200),
            cardNumber.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func createCardHolder() {
        //Name
        cardHolder.translatesAutoresizingMaskIntoConstraints = false
        cardHolder.font = UIFont(name: "Helvetica Neue", size: 12)
        cardHolder.textColor = cardHolderExpireDateColor
        cardHolder.text = cardHolderString
        frontView.addSubview(cardHolder)
        
        NSLayoutConstraint.activate([
            cardHolder.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            cardHolder.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15)
        ])
    }
    
    private func createCardHolderText() {
        //Card holder uilabel
        cardHolderText.translatesAutoresizingMaskIntoConstraints = false
        cardHolderText.font = UIFont(name: "Helvetica Neue", size: 10)
        cardHolderText.text = "CARD HOLDER"
        cardHolderText.textColor = cardHolderExpireDateTextColor
        frontView.addSubview(cardHolderText)
        
        NSLayoutConstraint.activate([
            cardHolderText.bottomAnchor.constraint(equalTo: cardHolder.topAnchor, constant: -3),
            cardHolderText.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15)
        ])
    }
    
    private func createExpireDate() {
        //Expire Date
        expireDate = AKMaskField()
        expireDate.translatesAutoresizingMaskIntoConstraints = false
        expireDate.font = UIFont(name: "Helvetica Neue", size: 12)
        expireDate.maskExpression = "{..}/{..}"
        expireDate.text = "MM/YY"
        expireDate.textColor = cardHolderExpireDateColor
        frontView.addSubview(expireDate)
        
        NSLayoutConstraint.activate([
            expireDate.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            expireDate.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -55)
        ])
    }
    
    private func createExpireDateText() {
        //Expire Date Text
        expireDateText.translatesAutoresizingMaskIntoConstraints = false
        expireDateText.font = UIFont(name: "Helvetica Neue", size: 10)
        expireDateText.text = "EXPIRY"
        expireDateText.textColor = cardHolderExpireDateTextColor
        frontView.addSubview(expireDateText)
        
        NSLayoutConstraint.activate([
            expireDateText.bottomAnchor.constraint(equalTo: expireDate.topAnchor, constant: -3),
            expireDateText.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -58)
        ])
    }
    
    private func createChipImage() {
        //Chip image
        chipImg.translatesAutoresizingMaskIntoConstraints = false
        chipImg.alpha = 0.5
        chipImg.image = chipImage
        frontView.addSubview(chipImg)
        
        NSLayoutConstraint.activate([
            chipImg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            chipImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            chipImg.widthAnchor.constraint(equalToConstant: 45),
            chipImg.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    private func createBackLine() {
        //BackLine
        backLine.translatesAutoresizingMaskIntoConstraints = false
        backLine.backgroundColor = backLineColor
        backView.addSubview(backLine)
        
        NSLayoutConstraint.activate([
            backLine.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
            backLine.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            backLine.widthAnchor.constraint(equalToConstant: 300),
            backLine.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createCVC() {
        //CVC textfield
        cvc.translatesAutoresizingMaskIntoConstraints = false
        cvc.maskExpression = "..."
        cvc.text = "CVC"
        cvc.backgroundColor = .white
        cvc.textAlignment = NSTextAlignment.center
        cvc.isUserInteractionEnabled = false
        backView.addSubview(cvc)
        
        NSLayoutConstraint.activate([
            cvc.topAnchor.constraint(equalTo: backLine.bottomAnchor, constant: 10),
            cvc.widthAnchor.constraint(equalToConstant: 50),
            cvc.heightAnchor.constraint(equalToConstant: 25),
            cvc.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setType(colors: [UIColor], alpha: CGFloat, back: UIColor) {
        UIView.animate(withDuration: 2, animations: { () -> Void in
            self.gradientLayer.colors = [colors[0].cgColor, colors[1].cgColor]
        })
        self.backView.backgroundColor = back
        self.chipImg.alpha = alpha
    }
    
    private func flip() {
        var showingSide = frontView
        var hiddenSide = backView
        if showingBack {
            (showingSide, hiddenSide) = (backView, frontView)
        }
        
        UIView.transition(from:showingSide,
                          to: hiddenSide,
                          duration: 0.7,
                          options: [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews],
                          completion: nil)
    }
    
    public func paymentCardTextFieldDidChange(cardNumber: String? = "", expirationYear: UInt, expirationMonth: UInt, cvc: String? = "") {
        self.cardNumber.text = cardNumber
        
        self.expireDate.text = NSString(format: "%02ld", expirationMonth) as String + "/" + (NSString(format: "%02ld", expirationYear) as String)
        
        if expirationMonth == 0 {
            expireDate.text = "MM/YY"
        }
        let v = CreditCardValidator()
        self.cvc.text = cvc
        
        if (cardNumber?.characters.count)! >= 7 || (cardNumber?.characters.count)! < 4 {
            
            guard let type = v.type(from: "\(cardNumber)") else {
                self.brandImageView.image = nil
                if let name = colors["NONE"] {
                    setType(colors: [name[0], name[1]], alpha: 0.5, back: name[0])
                }
                return
            }
            
            // Visa, Mastercard, Amex etc.
            if let name = colors[type.name] {
                self.brandImageView.image = UIImage(named: type.name)
                setType(colors: [name[0], name[1]], alpha: 1, back: name[0])
            }else{
                setType(colors: [self.colors["DEFAULT"]![0], self.colors["DEFAULT"]![0]], alpha: 1, back: self.colors["DEFAULT"]![0])
            }
        }
    }
    
    public func paymentCardTextFieldDidEndEditingExpiration(expirationYear: UInt) {
        
        if "\(expirationYear)".characters.count <= 1 {
            expireDate.text = "MM/YY"
        }
    }

    public func paymentCardTextFieldDidBeginEditingCVC() {
        if !showingBack {
            flip()
            showingBack = true
        }
    }
    
    public func paymentCardTextFieldDidEndEditingCVC() {
        if showingBack {
            flip()
            showingBack = false
        }
    }
}

//: CardColors
extension CreditCardForumView {
    
    fileprivate func setBrandColors() {
        colors[Brands.NONE.rawValue] = [UIColor.hexStr(hexStr: "#363434", alpha: 1), UIColor.hexStr(hexStr: "#363434", alpha: 1)]
        colors[Brands.Visa.rawValue] = [UIColor.hexStr(hexStr: "#5D8BF2", alpha: 1), UIColor.hexStr(hexStr: "#3545AE", alpha: 1)]
        colors[Brands.MasterCard.rawValue] = [UIColor.hexStr(hexStr: "#ED495A", alpha: 1), UIColor.hexStr(hexStr: "#8B1A2B", alpha: 1)]
        colors[Brands.Amex.rawValue] = [UIColor.hexStr(hexStr: "#005B9D", alpha: 1), UIColor.hexStr(hexStr: "#132972", alpha: 1)]
        colors[Brands.JCB.rawValue] = [UIColor.hexStr(hexStr: "#265797", alpha: 1), UIColor.hexStr(hexStr: "#3d6eaa", alpha: 1)]
        colors["Diners Club"] = [UIColor.hexStr(hexStr: "#5b99d8", alpha: 1), UIColor.hexStr(hexStr: "#4186CD", alpha: 1)]
        colors[Brands.Discover.rawValue] = [UIColor.hexStr(hexStr: "#e8a258", alpha: 1), UIColor.hexStr(hexStr: "#D97B16", alpha: 1)]
        colors[Brands.DEFAULT.rawValue] = [UIColor.hexStr(hexStr: "#5D8BF2", alpha: 1), UIColor.hexStr(hexStr: "#3545AE", alpha: 1)]
    }
}






