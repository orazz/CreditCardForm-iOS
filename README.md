# CreditCardForm

[![CI Status](https://travis-ci.org/orazz/CreditCardForm-iOS.svg?branch=master)](https://travis-ci.org/orazz/CreditCardForm-iOS)
<a href="https://cocoapods.org/pods/CreditCardForm"><img src="https://img.shields.io/badge/pod-0.0.8-blue.svg" alt="CocoaPods compatible" /></a>
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat" alt="Swift 3 compatible" /></a>
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://github.com/orazz/CreditCardForm-iOS/blob/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>

CreditCardForm is iOS framework that allows developers to create the UI which replicates an actual Credit Card.

<strong style="color:red">Fixed typo use CreditCardForm instead ~~CreditCardForum~~</strong>

### Screenshots
<img src="https://dotjpg.co/8bu.png" width="300"> <img src="Example/Screens/CreditCardDemo.gif" width="300">

## Example

To run the example project, clone the repo, and run `pod install` from the Demo-\* directory first.

## Supported Cards

- [x] MasterCard
- [x] Visa
- [x] JCB
- [x] Diners
- [x] Discover
- [x] Amex

## Requirements

* Xcode 8
* iOS 8.1+

## Installation

#### Using [CocoaPods](http://cocoapods.org)

CreditCardForm is available through CocoaPods. To install it, simply add the following line to your `Podfile`:

```ruby
pod "CreditCardForm"
```

#### Using [Carthage](https://github.com/Carthage/Carthage)

CreditCardForm is available through Carthage. To install it, simply add the following line to your `Cartfile`:

```ruby
github "orazz/CreditCardForm-iOS"
```

#### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate CreditCardForm into your project manually.

1. Download and drop ```CreditCardForm``` in your project.  
2. Done!  

## Usage example

First step: this framework integrated with Stripe, you must install [Stripe](https://stripe.com/docs/mobile/ios)

#### Storyboard
Create a view set a class CreditCardFormView (preferred frame size: 300x200). <br/> 
Following this you will have to go through a few simple steps outlined below in order to get everything up and running.
``` swift
import Stripe
import CreditCardForm
```
#### Swift
``` swift
@IBOutlet weak var creditCardForm: CreditCardFormView!

// Stripe textField
let paymentTextField = STPPaymentCardTextField()
```

#### Add the following code in the viewDidLoad function in your view controller

```swift
// Set up stripe textfield
paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
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
paymentTextField.topAnchor.constraint(equalTo: creditCardForm.bottomAnchor, constant: 20),
paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
paymentTextField.heightAnchor.constraint(equalToConstant: 44)
])
```

#### Optional - Delegate Methods

In order to use the delegate methods first set the delegate of Stripe to the parent view controller when setting it up

paymentTextField.delegate = self

After that you will be able to set up the following delegate methods inside of your parent view controller

``` swift
func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
creditCardForm.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationYear, cvc: textField.cvc)
}

func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
creditCardForm.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
}

func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
creditCardForm.paymentCardTextFieldDidBeginEditingCVC()
}

func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
creditCardForm.paymentCardTextFieldDidEndEditingCVC()
}
```

**You should now be ready to use CreditCardForm!!**

## Customization

**1) Colors**
``` swift
creditCardForm.backgroundColor (UIColor)
creditCardForm.cardHolderExpireDateColor (UIColor)
creditCardForm.cardHolderExpireDateTextColor (UIColor)
creditCardForm.backLineColor (UIColor)

// Brands Color brand name, front color, back color
[String: [UIColor]]
creditCardForm.colors[Brands.Visa.rawValue] = [UIColor.black, UIColor.black]
...
creditCardForm.colors[Brands.MasterCard.rawValue] = [UIColor.black, UIColor.black]
```
**2) Images**
``` swift
creditCardForm.chipImage (UIImage)
```
**3) Placeholders**
``` swift
creditCardForm.cardHolderString (String)
creditCardForm.expireDatePlaceholderText (String)
```
**Card number: [Configuring the Mask Field](https://github.com/artemkrachulov/AKMaskField#configuring-the-mask-field) **
``` swift
creditCardForm.cardNumberMaskExpression (String)
creditCardForm.cardNumberMaskTemplate (String)

creditCardForm.cardNumberFontSize (CGFloat)
```    
## Contribute

We would love for you to contribute to **CreditCardForm**, check the ``LICENSE`` file for more info.

## Meta

[Oraz Atakishi](https://github.com/orazz), orazz.tm@gmail.com

#### 3rd party libraries

[CreditCardValidator](https://github.com/vitkuzmenko/CreditCardValidator) <br/>
[AKMaskField](https://github.com/artemkrachulov/AKMaskField)

## License

CreditCardForm is available under the MIT license. See the LICENSE file for more info.
