# AKMaskField

![Preview](https://raw.githubusercontent.com/artemkrachulov/AKMaskField/master/Assets/preview.gif)

AKMaskField is UITextField subclass which allows enter data in the fixed quantity and in the certain format (credit cards, telephone numbers, dates, etc.). You only need setup mask and mask template visible for user.

## Features

* Easy in use
* Possibility to setup input field from a code or Settings Panel
* Smart template
* Support of dynamic change of a mask
* Fast processing of a input field
* Smart copy / insert action

## Requirements

- iOS 8.0+
- Xcode 7.3+

## Installation

1. Clone or download demo project.
2. Add the AKMaskField folder to your project (To copy the file it has to be chosen).

## Usage

### Storyboard

Create a text field `UITextField` and set a class `AKMaskField` in the Inspector / Accessory Panel tab. Specify necessary attributes in the Inspector / Accessory Attributes tab.

Example:

* **MaskExpression**: {dddd}-{DDDD}-{WaWa}-{aaaa}
* **MaskTemplate**: ABCD-EFGH-IJKL-MNOP


### Programmatically

Setup mask field in your view controller.

```swift
var field: AKMaskField!

override func viewDidLoad() {
    super.viewDidLoad()

    field = AKMaskField()
    field.maskExpression = "{dddd}-{DDDD}-{WaWa}-{aaaa}"
    field.maskTemplate = "ABCD-EFGH-IJKL-MNOP"
}
```

## Configuring the Mask Field

```swift
var maskExpression: String?
```

The string value that has blocks with pattern symbols that determine the certain format of input data. Wrap each mask block with proper bracket character.

**The predetermined formats**: 

| Mask symbol (pattern)   | Input format |
| :-----------: | :------------ |
| **d** | Number, decimal number from 0 to 9 |
| **D** | Any symbol, except decimal number |
| **W** | Not an alphabetic symbol |
| **a** | Alphabetic symbol, a-Z | 
| **.** | Corresponds to any symbol (default) |

Default value of this property is `nil`.

```swift
var maskTemplate: String
```

The text that represents the mask filed with replacing mask symbol by template character.

| Characters count   | Input format |
| :-----------: | :------------ |
| **1** | Template character will be copied to each mask block with repeating equal block length. |
| **Equal** | Template length equal to mask without brackets. Template characters will replace mask blocks in same range.|

Default value of this property is `*`.

```swift
func setMask(mask: String, withMaskTemplate maskTemplate: String)
```

Use this method to set the mask and template parameters.

**Parameters**

- `maskExpression` : Mask (read above).
- `maskTemplate` : Mask template (read above).

> You can also set default `placeholder` property. The placeholder will shows only when mask field is clear.


```swift
var maskBlockBrackets: AKMaskFieldBrackets
```

Open and close bracket character for the mask block.
Default value of this property is `{` and `}`.

## Accessing the Text Attributes

```swift
public var text: String?
```

The text displayed by the mask field. 

## Mask Field actions

```swift
func refreshMask()
```

Manually refresh the mask field


## Accessing the Delegate

```swift
weak var maskDelegate: AKMaskFieldDelegate?
```

The receiver’s delegate.

## Getting the Mask Field status

```swift
var maskStatus: AKMaskFieldStatus { get }
```

Returns the current status of the mask field. The value of the property is a constant. See **AKMaskFieldStatus** for descriptions of the possible values.

## Getting the Mask Field object

```swift
var maskBlocks: [AKMaskFieldBlock] { get }
```

Returns an array containing all the Mask Field blocks

## AKMaskFieldDelegate

### Managing Editing

```swift
optional func maskFieldShouldBeginEditing(maskField: AKMaskField) -> Bool
```

Asks the delegate if editing should begin in the specified mask field.

**Parameters**

- `maskField` : The mask field in which editing is about to begin. 

```swift
optional func maskFieldDidBeginEditing(maskField: AKMaskField)
```

Asks the delegate if editing should begin in the specified mask field.

**Parameters**

- `maskField` : The mask field in which editing is about to begin. 

```swift
optional func maskFieldShouldEndEditing(maskField: AKMaskField) -> Bool
```

Asks the delegate if editing should stop in the specified mask field.

**Parameters**

- `maskField` : The mask field in which editing is about to end.

```swift
optional func maskFieldDidEndEditing(maskField: AKMaskField)
```

Tells the delegate that editing stopped for the specified mask field.

**Parameters**

- `maskField` : The mask field for which editing ended.

```swift
optional func maskField(maskField: AKMaskField, didChangedWithEvent event: AKMaskFieldEvent)
```

Tells the delegate that specified mask field change text with event.

**Parameters**

- `maskField` : The mask field for which event changed.
- `event` : Event constant value received after manipulations.

### Editing the Mask Field’s Block

```swift
optional func maskField(maskField: AKMaskField, shouldChangeBlock block: AKMaskFieldBlock, inout inRange range: NSRange, inout replacementString string: String) -> Bool
```

Asks the delegate if the specified mask block should be changed.

**Parameters**

- `maskField` : The mask field containing the text.
- `block` : Target block. See ** AKMaskFieldBlock** more information.
- `range` : The range of characters to be replaced (inout parameter).
- `string` : The replacement string for the specified range (inout parameter).

## Structures

### AKMaskFieldBlock

A structure that contains the mask block main properties.

**General**

```swift
var index: Int
```

Block index in the mask

```swift
var status: AKMaskFieldStatus { get }
```

Returns the current block status.

```swift
var chars: [AKMaskFieldBlockCharacter]
```

An array containing all characters inside block. See `AKMaskFieldBlockCharacter` structure information.

**Pattern**

```swift
var pattern: String { get }
```

The mask pattern that represent current block.

```swift
var patternRange: NSRange { get }
```

Location of the mask pattern in the mask.

**Mask template**

```swift
var template: String { get }
```

The mask template string that represent current block.

```swift
var templateRange: NSRange { get }
```

Location of the mask template string in the mask template.

### AKMaskFieldBlockCharacter

A structure that contains the block character main properties.

**General**

```swift
var index: Int
```

Character index in the block.

```swift
var blockIndex: Int
```

The block index in the mask.

```swift
var status: AKMaskFieldStatus
```

Current character status.

**Pattern**

```swift
var pattern: AKMaskFieldPatternCharacter
```

The mask pattern character. See `AKMaskFieldPatternCharacter` costant information.

```swift
var patternRange: NSRange
```

Location of the pattern character in the mask.

**Mask template**

```swift
var template: Character
```

The mask template character.

```swift
var templateRange: NSRange
```

Location of the mask template character in the mask template.

## Constants

### AKMaskFieldStatus

```swift
enum AKMaskFieldStatus {
	case Clear
	case Incomplete
	case Complete
}
```

The Mask Field, Block and Block Character status property constant.

### AKMaskFieldEvent

```swift
enum AKMaskFieldEvet {
	case None
	case Insert
	case Delete
	case Replace
}
```

Event constant value received after manipulations with the Mask Field.

### AKMaskFieldPatternCharacter

```swift
enum AKMaskFieldPatternCharacter: String {
  case NumberDecimal = "d"
  case NonDecimal = "D"
  case NonWord = "W"
  case Alphabet = "a"
  case Any = "."
}
```

Single block character pattern constant.

**Constatns**

- `NumberDecimal`	: Number, decimal number from 0 to 9
- `NonDecimal`	: Any symbol, except decimal number
- `NonWord`	: Not an alphabetic symbol
- `Alphabet`	: Alphabetic symbol, a-Z
- `Any`	: Corresponds to any symbol (default)

```swift
func pattern() -> String
```

Returns regular expression pattern.

---

Please do not forget to ★ this repository to increases its visibility and encourages others to contribute.

### Author

Artem Krachulov: [www.artemkrachulov.com](http://www.artemkrachulov.com/)
Mail: [artem.krachulov@gmail.com](mailto:artem.krachulov@gmail.com)

### License

Released under the [MIT license](http://www.opensource.org/licenses/MIT)
