//
//  AKMaskFieldPatternCharacter.swift
//  AKMaskField
//  GitHub: https://github.com/artemkrachulov/AKMaskField
//
//  Created by Artem Krachulov
//  Copyright (c) 2016 Artem Krachulov. All rights reserved.
//  Website: http://www.artemkrachulov.com/
//

/// Single block character pattern constant.
enum AKMaskFieldPatternCharacter: String {
  
  //  MARK: - Constants
  
  case NumberDecimal = "d"
  case NonDecimal    = "D"
  case NonWord       = "W"
  case Alphabet      = "a"
  case AnyChar       = "."
  
  /// Returns regular expression pattern.
  func pattern() -> String {
    switch self {
    case .NumberDecimal   : return "\\d"
    case .NonDecimal      : return "\\D"
    case .NonWord         : return "\\W"
    case .Alphabet        : return "[a-zA-Z]"
    default               : return "."
    }
  }
}
