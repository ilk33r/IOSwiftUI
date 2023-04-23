//
//  StringExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation

public extension String {
    
    // MARK: - Substring
    
    func appendingOccurrences(ofString aString: String, occurence: Int) -> String {
        var result = self
        
        for _ in 0..<occurence {
            result.append(aString)
        }
        
        return result
    }
    
    func substring(start: Int, count: Int) -> String {
        let startIdx = self.index(self.startIndex, offsetBy: start)
        let endOffset = min(self.count, start + count)
        let endIdx = self.index(self.startIndex, offsetBy: endOffset)
        
        return String(self[startIdx..<endIdx])
    }
    
    func substring(maxLenth: Int) -> String {
        let applicableLength = min(self.count, maxLenth)
        return self.substring(start: 0, count: applicableLength)
    }
    
    // MARK: - Case
    
    func camelCased() -> String {
        var result = ""
        let words = self.components(separatedBy: " ")
        
        words.enumerated().forEach { it in
            if it.offset == 0 {
                result.append(it.element.lowercaseFirstLetter())
            } else {
                result.append(it.element.uppercaseFirstLetter())
            }
        }
        
        return result
    }
    
    func lowercaseFirstLetter() -> String {
        if self.count <= 1 {
            return self.lowercased()
        }
        
        return String(format: "%@%@", self.substring(start: 0, count: 1).lowercased(), self.substring(start: 1, count: self.count))
    }
    
    func uppercaseFirstLetter() -> String {
        if self.count <= 1 {
            return self.lowercased()
        }
        
        return String(format: "%@%@", self.substring(start: 0, count: 1).uppercased(), self.substring(start: 1, count: self.count))
    }
    
    // MARK: - Trim
    
    func trim(characterSet: CharacterSet) -> String {
        String(self.unicodeScalars.filter(characterSet.contains))
    }
    
    func trimNonAlphaNumericCharacters() -> String {
        self.trim(characterSet: CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"))
    }
    
    func trimLetters() -> String {
        self.trim(characterSet: CharacterSet(charactersIn: "0123456789,."))
    }
    
    // MARK: - Pattern
    
    func applyPattern(pattern: String) -> String {
        var currentIndex = 0
        var formattedString = ""
        
        for i in 0..<pattern.count {
            if currentIndex >= self.count {
                break
            }
            let patternCharacter = pattern[String.Index(utf16Offset: i, in: pattern)]
            if patternCharacter == "#" {
                let currentCharacter = self[String.Index(utf16Offset: currentIndex, in: self)]
                formattedString.append(currentCharacter)
                currentIndex += 1
            } else if patternCharacter == "*" {
                if currentIndex < self.count {
                    let startIndex = String.Index(utf16Offset: currentIndex, in: self)
                    let endIndex = String.Index(utf16Offset: self.count, in: self)
                    let string = self[startIndex..<endIndex]
                    formattedString.append(String(string))
                }
                break
            } else {
                formattedString.append(patternCharacter)
            }
        }
        
        return formattedString
    }
    
    // MARK: - JSON
    
    func toJsonDictionary() -> [String: Any]? {
        if let jsonData = self.data(using: .utf8) {
            let jsonDict = try? JSONSerialization.jsonObject(with: jsonData)
            return jsonDict as? [String: Any]
        }
        
        return nil
    }
}
