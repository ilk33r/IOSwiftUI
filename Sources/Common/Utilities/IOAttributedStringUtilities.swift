//
//  IOAttributedStringUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.01.2023.
//

import Foundation

public struct IOAttributedStringUtilities {
    
    // MARK: - Defs
    
    private struct Element {
        
        let hasAttributedElement: Bool
        let attributedPartRange: NSRange
        let htmlPartRange: NSRange
        let replacingString: String?
        let urlString: String?
        
        init(hasAttributedElement: Bool, attributedPartRange: NSRange, htmlPartRange: NSRange, replacingString: String?, urlString: String?) {
            self.hasAttributedElement = hasAttributedElement
            self.attributedPartRange = attributedPartRange
            self.htmlPartRange = htmlPartRange
            self.replacingString = replacingString
            self.urlString = urlString
        }
    }
    
    // MARK: - Utils
    
    public static func createAttributes(fromHtmlString htmlString: String, plainString: inout String) -> [IOAttributedStringModel] {
        // Create result array
        var resultArray = [IOAttributedStringModel]()
        
        // Create regex for
        let regexPattern = "<([a-z]*)\\b[^>]*>(.*?)</\\1>"
        
        // Create updated string
        var updatedString = htmlString
        var removedCharacterCount = 0
        
        // Match regex
        let regex = try? NSRegularExpression(pattern: regexPattern, options: .init(arrayLiteral: .caseInsensitive, .useUnixLineSeparators))
        var searchedRange = NSRange(location: 0, length: htmlString.count)
        var matches = regex?.matches(in: htmlString, range: searchedRange)
        
        // Check html tags found
        if let matches, matches.count > 0 {
            // Loop throught tags
            for result in matches {
                // Check tag is bold
                var attributedStringElement = Self.attributedBoldTags(forResult: result, htmlString: htmlString)
                if attributedStringElement.hasAttributedElement {
                    // Obtain ranges
                    let htmlPartRange = NSRange(location: attributedStringElement.htmlPartRange.location - removedCharacterCount, length: attributedStringElement.htmlPartRange.length)
                    let attributedPartRange = NSRange(location: attributedStringElement.attributedPartRange.location - removedCharacterCount, length: attributedStringElement.attributedPartRange.length)
                    
                    // Replace updated string
                    let updatedNSString = updatedString as NSString
                    updatedString = updatedNSString.replacingCharacters(in: htmlPartRange, with: attributedStringElement.replacingString ?? "")
                    removedCharacterCount += htmlPartRange.length - (attributedStringElement.replacingString?.count ?? 0)
                    
                    // Create attributed string model
                    resultArray.append(
                        IOAttributedStringModel(
                            range: attributedPartRange,
                            type: .bold,
                            urlString: nil
                        )
                    )
                    
                    continue
                }
                
                attributedStringElement = Self.attributedLinkTags(forResult: result, htmlString: htmlString)
                if attributedStringElement.hasAttributedElement {
                    // Obtain ranges
                    let htmlPartRange = NSRange(location: attributedStringElement.htmlPartRange.location - removedCharacterCount, length: attributedStringElement.htmlPartRange.length)
                    let attributedPartRange = NSRange(location: attributedStringElement.attributedPartRange.location - removedCharacterCount, length: attributedStringElement.attributedPartRange.length)
                    
                    // Replace updated string
                    let updatedNSString = updatedString as NSString
                    updatedString = updatedNSString.replacingCharacters(in: htmlPartRange, with: attributedStringElement.replacingString ?? "")
                    removedCharacterCount += htmlPartRange.length - (attributedStringElement.replacingString?.count ?? 0)
                    
                    // Create attributed string model
                    resultArray.append(
                        IOAttributedStringModel(
                            range: attributedPartRange,
                            type: .link,
                            urlString: attributedStringElement.urlString
                        )
                    )
                    
                    continue
                }
            }
        }
        
        plainString = updatedString
        return resultArray
    }
    
    public static func url(fromHTMLText html: String) -> String? {
        // Create regex for
        let regexPattern = "href=\"(.*?)\""
        
        // Match regex
        let regex = try? NSRegularExpression(pattern: regexPattern, options: .init(arrayLiteral: .caseInsensitive, .useUnixLineSeparators))
        let searchedRange = NSRange(location: 0, length: html.count)
        let matches = regex?.matches(in: html, range: searchedRange)
        
        // Check html tags found
        if
            let matches,
            matches.count > 0,
            let result = matches.first,
            result.numberOfRanges > 1
        {
            let urlRange = result.range(at: 1)
            let htmlNSString = html as NSString
            let urlString = htmlNSString.substring(with: urlRange)
            
            return urlString
        }
        
        return nil
    }
    
    // MARK: - Helper Methods

    private static func attributedBoldTags(forResult result: NSTextCheckingResult, htmlString: String) -> Element {
        // Check number of range
        if result.numberOfRanges == 3 {
            let tagNameRange = result.range(at: 1)
            let htmlNSString = htmlString as NSString
            let tagName = htmlNSString.substring(with: tagNameRange).lowercased()
            
            if tagName == "strong" || tagName == "b" {
                // Obtain html part
                let htmlPartRange = result.range(at: 0)
                
                // Obtain plain part
                let plainRange = result.range(at: 2)
                let plainPart = htmlNSString.substring(with: plainRange)
                
                // Create a attributed string element
                return Element(
                    hasAttributedElement: true,
                    attributedPartRange: NSRange(location: htmlPartRange.location, length: plainRange.length),
                    htmlPartRange: htmlPartRange,
                    replacingString: plainPart,
                    urlString: nil
                )
            }
        }
        
        // Create a attributed string element
        return Element(
            hasAttributedElement: false,
            attributedPartRange: NSRange(location: 0, length: 0),
            htmlPartRange: NSRange(location: 0, length: 0),
            replacingString: nil,
            urlString: nil
        )
    }
    
    private static func attributedLinkTags(forResult result: NSTextCheckingResult, htmlString: String) -> Element {
        // Check number of range
        if result.numberOfRanges == 3 {
            let tagNameRange = result.range(at: 1)
            let htmlNSString = htmlString as NSString
            let tagName = htmlNSString.substring(with: tagNameRange).lowercased()
            
            if tagName == "a" {
                // Obtain html part
                let htmlPartRange = result.range(at: 0)
                let htmlPart = htmlNSString.substring(with: htmlPartRange)
                let url = Self.url(fromHTMLText: htmlPart)
                
                // Obtain plain part
                let plainRange = result.range(at: 2)
                let plainPart = htmlNSString.substring(with: plainRange)
                
                // Create a attributed string element
                return Element(
                    hasAttributedElement: true,
                    attributedPartRange: NSRange(location: htmlPartRange.location, length: plainRange.length),
                    htmlPartRange: htmlPartRange,
                    replacingString: plainPart,
                    urlString: url
                )
            }
        }
        
        // Create a attributed string element
        return Element(
            hasAttributedElement: false,
            attributedPartRange: NSRange(location: 0, length: 0),
            htmlPartRange: NSRange(location: 0, length: 0),
            replacingString: nil,
            urlString: nil
        )
    }
}
