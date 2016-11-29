//
//  AKMaskFieldBlock.swift
//  AKMaskField
//  GitHub: https://github.com/artemkrachulov/AKMaskField
//
//  Created by Artem Krachulov
//  Copyright (c) 2016 Artem Krachulov. All rights reserved.
//  Website: http://www.artemkrachulov.com/
//

import Foundation

/// A structure that contains the mask block main properties.
public struct AKMaskFieldBlock {
  
  //  MARK: - General
  
  /// Block index in the mask
  var index: Int
  
  /// Returns the current block status.
  var status: AKMaskFieldStatus {
    
    let completedChars: [AKMaskFieldBlockCharacter] = chars.filter { return $0.status != .clear }
    
    switch completedChars.count {
    case 0           : return .clear
    case chars.count : return .complete
    default          : return .incomplete
    }
  }
  
  /// An array containing all characters inside block.
  var chars: [AKMaskFieldBlockCharacter]
  
  //  MARK: - Pattern
  
  /// The mask pattern that represent current block.
  var pattern: String {

    var pattern: String = ""
    for char in chars {
       pattern += char.pattern.rawValue
    }
    return pattern
  }
  
  /// Location of the mask pattern in the mask.
  var patternRange: NSRange {
    return NSMakeRange(chars.first!.patternRange.location, chars.count)
  }
  
  //  MARK: - Mask template 
  
  /// The mask template string that represent current block.
  var template: String {
    var template: String = ""
    for char in chars {
      template.append(char.template)
    }
    return template
  }
  
  /// Location of the mask template string in the mask template.
  var templateRange: NSRange {
    return NSMakeRange(chars.first!.templateRange.location, chars.count)
  }
  

}
