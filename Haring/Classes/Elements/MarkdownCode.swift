//
//  MarkdownCode.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

open class MarkdownCode: MarkdownCommonElement {
    public var parsedRange: NSRange?
    
    public var parserDelegate: MarkdownParser?
    

  fileprivate static let regex = "(\\s+|^)(\\`+)(.+?)(\\2)"

  open var font: UIFont?
  open var color: UIColor?

  open var regex: String {
    return MarkdownCode.regex
  }

  public init(font: UIFont? = nil, color: UIColor? = nil) {
    self.font = font
    self.color = color
  }

  open func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange) {
    let matchString: String = attributedString.attributedSubstring(from: range).string
    guard let unescapedString = matchString.unescapeUTF16() else { return }
    attributedString.replaceCharacters(in: range, with: unescapedString)
  
    var amendedAttributes = attributes
    amendedAttributes[NSAttributedStringKey.backgroundColor] = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.0)
    amendedAttributes[NSAttributedStringKey.foregroundColor] = UIColor(red: 0.95, green: 0.25, blue: 0.44, alpha: 1.0)
    amendedAttributes[NSAttributedStringKey.font] = UIFont(name: "Menlo-Regular", size: 16)
  
    let newRange = (attributedString.string as NSString).range(of: unescapedString)
    attributedString.addAttributes(amendedAttributes, range: NSRange(location: range.location, length: newRange.length))
  }
}
