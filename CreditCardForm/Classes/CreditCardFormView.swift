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
public class CreditCardFormView : UIView {
    
    fileprivate var cardView: UIView    = UIView(frame: .zero)
    fileprivate var backView: UIView    = UIView(frame: .zero)
    fileprivate var frontView: UIView   = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
    fileprivate var gradientLayer       = CAGradientLayer()
    fileprivate var showingBack:Bool    = false
    
    fileprivate var backImage: UIImageView   = UIImageView(frame: .zero)
    fileprivate var brandImageView           = UIImageView(frame: .zero)
    fileprivate var cardNumber:AKMaskField   = AKMaskField(frame: .zero)
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
    public var chipImage = UIImage(named: "chip", in: Bundle.currentBundle(), compatibleWith: nil) {
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
    
    @IBInspectable
    public var expireDatePlaceholderText = "EXPIRY" {
        didSet {
            expireDateText.text = expireDatePlaceholderText
        }
    }
    
    @IBInspectable
    public var cardNumberMaskExpression = "{....} {....} {....} {....}" {
        didSet {
            cardNumber.maskExpression = cardNumberMaskExpression
        }
    }
    
    @IBInspectable
    public var cardNumberMaskTemplate = "**** **** **** ****" {
        didSet {
            cardNumber.maskTemplate = cardNumberMaskTemplate
        }
    }
    
    public var cardNumberFontSize: CGFloat = 20 {
        didSet {
            cardNumber.font = UIFont(name: "Helvetica Neue", size: cardNumberFontSize)
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
        cardView.backgroundColor = .clear
        self.addSubview(cardView)
        //CardView
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0.0));
    }
    
    private func createBackView() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = 6
        backView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        backView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        cardView.addSubview(backView)
        
        self.addConstraint(NSLayoutConstraint(item: backView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0.0));
    }
    
    private func createFrontView() {
        frontView.translatesAutoresizingMaskIntoConstraints = false
        frontView.layer.cornerRadius = 6
        frontView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        frontView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        cardView.addSubview(frontView)
        setGradientBackground(v: frontView, top: defaultCardColor.cgColor, bottom: defaultCardColor.cgColor)
        
        self.addConstraint(NSLayoutConstraint(item: frontView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: frontView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: frontView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: frontView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0.0));
    }
    
    private func createbackImage() {
        backImage.translatesAutoresizingMaskIntoConstraints = false
        backImage.image = UIImage(named: "back.jpg")
        backImage.contentMode = UIViewContentMode.scaleAspectFill
        frontView.addSubview(backImage)
        
        self.addConstraint(NSLayoutConstraint(item: backImage, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backImage, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backImage, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backImage, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0));
    }
    
    private func createBrandImageView() {
        //Card brand image
        brandImageView.translatesAutoresizingMaskIntoConstraints = false
        brandImageView.contentMode = UIViewContentMode.scaleAspectFit
        frontView.addSubview(brandImageView)
        
        self.addConstraint(NSLayoutConstraint(item: brandImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 10));
        
        self.addConstraint(NSLayoutConstraint(item: brandImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -10));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": brandImageView]));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": brandImageView]));
    }
    
    private func createCardNumber() {
        //Credit card number
        cardNumber.translatesAutoresizingMaskIntoConstraints = false
        cardNumber.maskExpression = cardNumberMaskExpression
        cardNumber.maskTemplate = cardNumberMaskTemplate
        cardNumber.textColor = cardHolderExpireDateColor
        cardNumber.isUserInteractionEnabled = false
        cardNumber.textAlignment = NSTextAlignment.center
        cardNumber.font = UIFont(name: "Helvetica Neue", size: cardNumberFontSize)
        frontView.addSubview(cardNumber)
        
        self.addConstraint(NSLayoutConstraint(item: cardNumber, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: cardNumber, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==200)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": cardNumber]));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": cardNumber]));
    }
    
    private func createCardHolder() {
        //Name
        cardHolder.translatesAutoresizingMaskIntoConstraints = false
        cardHolder.font = UIFont(name: "Helvetica Neue", size: 12)
        cardHolder.textColor = cardHolderExpireDateColor
        cardHolder.text = cardHolderString
        frontView.addSubview(cardHolder)
        
        self.addConstraint(NSLayoutConstraint(item: cardHolder, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -20));
        
        self.addConstraint(NSLayoutConstraint(item: cardHolder, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 15));
    }
    
    private func createCardHolderText() {
        //Card holder uilabel
        cardHolderText.translatesAutoresizingMaskIntoConstraints = false
        cardHolderText.font = UIFont(name: "Helvetica Neue", size: 10)
        cardHolderText.text = "CARD HOLDER"
        cardHolderText.textColor = cardHolderExpireDateTextColor
        frontView.addSubview(cardHolderText)
        
        self.addConstraint(NSLayoutConstraint(item: cardHolderText, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: cardHolder, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: -3));
        
        self.addConstraint(NSLayoutConstraint(item: cardHolderText, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 15));
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
        
        self.addConstraint(NSLayoutConstraint(item: expireDate, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -20));
        
        self.addConstraint(NSLayoutConstraint(item: expireDate, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -55));
    }
    
    private func createExpireDateText() {
        //Expire Date Text
        expireDateText.translatesAutoresizingMaskIntoConstraints = false
        expireDateText.font = UIFont(name: "Helvetica Neue", size: 10)
        expireDateText.text = expireDatePlaceholderText
        expireDateText.textColor = cardHolderExpireDateTextColor
        frontView.addSubview(expireDateText)
        
        self.addConstraint(NSLayoutConstraint(item: expireDateText, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: expireDate, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: -3));
        
        self.addConstraint(NSLayoutConstraint(item: expireDateText, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -58));
    }
    
    private func createChipImage() {
        //Chip image
        chipImg.translatesAutoresizingMaskIntoConstraints = false
        chipImg.alpha = 0.5
        chipImg.image = chipImage
        frontView.addSubview(chipImg)
        
        self.addConstraint(NSLayoutConstraint(item: chipImg, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 15));
        
        self.addConstraint(NSLayoutConstraint(item: chipImg, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: cardView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 15));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==45)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": chipImg]));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": chipImg]));
    }
    
    private func createBackLine() {
        //BackLine
        backLine.translatesAutoresizingMaskIntoConstraints = false
        backLine.backgroundColor = backLineColor
        backView.addSubview(backLine)
        
        self.addConstraint(NSLayoutConstraint(item: backLine, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: backView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 20));
        
        self.addConstraint(NSLayoutConstraint(item: backLine, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: backView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==300)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": backLine]));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==50)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": backLine]));
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
        
        self.addConstraint(NSLayoutConstraint(item: cvc, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: backLine, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 10));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==50)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": cvc]));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==25)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": cvc]));
        
        self.addConstraint(NSLayoutConstraint(item: cvc, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: backView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -10));
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
                self.brandImageView.image = UIImage(named: type.name, in: Bundle.currentBundle(), compatibleWith: nil)
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
extension CreditCardFormView {
    
    fileprivate func setBrandColors() {
        colors[Brands.NONE.rawValue] = [defaultCardColor, defaultCardColor]
        colors[Brands.Visa.rawValue] = [UIColor.hexStr(hexStr: "#5D8BF2", alpha: 1), UIColor.hexStr(hexStr: "#3545AE", alpha: 1)]
        colors[Brands.MasterCard.rawValue] = [UIColor.hexStr(hexStr: "#ED495A", alpha: 1), UIColor.hexStr(hexStr: "#8B1A2B", alpha: 1)]
        colors[Brands.Amex.rawValue] = [UIColor.hexStr(hexStr: "#005B9D", alpha: 1), UIColor.hexStr(hexStr: "#132972", alpha: 1)]
        colors[Brands.JCB.rawValue] = [UIColor.hexStr(hexStr: "#265797", alpha: 1), UIColor.hexStr(hexStr: "#3d6eaa", alpha: 1)]
        colors["Diners Club"] = [UIColor.hexStr(hexStr: "#5b99d8", alpha: 1), UIColor.hexStr(hexStr: "#4186CD", alpha: 1)]
        colors[Brands.Discover.rawValue] = [UIColor.hexStr(hexStr: "#e8a258", alpha: 1), UIColor.hexStr(hexStr: "#D97B16", alpha: 1)]
        colors[Brands.DEFAULT.rawValue] = [UIColor.hexStr(hexStr: "#5D8BF2", alpha: 1), UIColor.hexStr(hexStr: "#3545AE", alpha: 1)]
    }
}


