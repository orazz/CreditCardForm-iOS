//
//  AKMaskFieldBlockCharacter.swift
//  AKMaskField
//  GitHub: https://github.com/artemkrachulov/AKMaskField
//
//  Created by Artem Krachulov
//  Copyright (c) 2016 Artem Krachulov. All rights reserved.
//  Website: http://www.artemkrachulov.com/
//

import Foundation

/// A structure that contains the block character main properties.
public struct AKMaskFieldBlockCharacter {

  //  MARK: - General
  
  /// Character index in the block.
  var index: Int
  
  /// The block index in the mask.
  var blockIndex: Int
  
  /// Current character status.
  var status: AKMaskFieldStatus
  
  //  MARK: - Pattern
  
  /// The mask pattern character.
  var pattern: AKMaskFieldPatternCharacter!
  
  /// Location of the pattern character in the mask.
  var patternRange: NSRange
  
  //  MARK: - Mask template
  
  /// The mask template character.
  var template: Character!
  
  /// Location of the mask template character in the mask template.
  var templateRange: NSRange
}