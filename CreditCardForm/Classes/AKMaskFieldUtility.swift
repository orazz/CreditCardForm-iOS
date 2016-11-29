//
//  AKMaskFieldUtility.swift
//  AKMaskField
//  GitHub: https://github.com/artemkrachulov/AKMaskField
//
//  Created by Artem Krachulov
//  Copyright (c) 2016 Artem Krachulov. All rights reserved.
//  Website: http://www.artemkrachulov.com/
//

import UIKit

class AKMaskFieldUtility {

  /// [Source](http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index)
  class func rangeFromString(_ string: String, nsRange: NSRange) -> Range<String.Index>! {
    
    
    guard
        let from16 = string.utf16.index(string.utf16.startIndex, offsetBy: nsRange.location, limitedBy: string.utf16.endIndex),
        let to16 = string.utf16.index(from16, offsetBy: nsRange.length, limitedBy: string.utf16.endIndex),
        let from = String.Index(from16, within: string),
        let to = String.Index(to16, within: string)
        else { return nil }
    return from ..< to
    /*
    
    let from16 = string.utf16.startIndex.advancedBy(nsRange.location, limit: string.utf16.endIndex)
    let to16 = from16.advancedBy(nsRange.length, limit: string.utf16.endIndex)
    
    if let from = String.Index(from16, within: string),
      let to = String.Index(to16, within: string) {
      return from ..< to
    }
    return nil*/
  }
  
  class func substring(_ sourceString: String?, withNSRange range: NSRange) -> String {
    guard let sourceString = sourceString else {
      return ""
    }
    return sourceString.substring(with: rangeFromString(sourceString, nsRange: range))
  }
  
  class func replace(_ sourceString: inout String!, withString string: String, inRange range: NSRange) {
    sourceString = sourceString.replacingCharacters(in: rangeFromString(sourceString, nsRange: range), with: string)
  }
  
  class func replacingOccurrencesOfString(_ string: inout String!, target: String, withString replacement: String) {    
    string = string.replacingOccurrences(of: target, with: replacement, options: .regularExpression, range: nil)
  }
  
  class func maskField(_ maskField: UITextField, moveCaretToPosition position: Int) {
    guard let caretPosition = maskField.position(from: maskField.beginningOfDocument, offset: position) else {
      return
    }
    
    maskField.selectedTextRange = maskField.textRange(from: caretPosition, to: caretPosition)
  }
  
  class func matchesInString(_ string: String, pattern: String) -> [NSTextCheckingResult] {
    return  try!
      NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        .matches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, string.characters.count))
  }
  
  class func findIntersection(_ ranges: [NSRange], withRange range: NSRange) -> [NSRange?] {
    
    var intersectRanges = [NSRange?]()
    
    for r in ranges {
      
      var intersectRange: NSRange!
      
      let delta = r.location - range.location
      var location, length, tail: Int
      
      if delta <= 0 {
        location = range.location
        length   = range.length
        tail     = r.length - abs(delta)
      } else {
        location = r.location
        length   = r.length
        tail     = range.length - abs(delta)
      }
      
      if tail > 0 && length > 0 {
        intersectRange = NSMakeRange(location, min(tail, length))
      }
      
      intersectRanges.append(intersectRange)
    }
    return intersectRanges
  } 
}
