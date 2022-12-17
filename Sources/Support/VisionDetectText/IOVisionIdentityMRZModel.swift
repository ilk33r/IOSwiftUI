//
//  IOVisionIdentityMRZModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation

public struct IOVisionIdentityMRZModel {
    
    // MARK: - Defs
    
    public enum MRZError: Error {
        case parseError
    }
    
    final public class ModelData {
        
        public var birthDate: String?
        public var documentNumber: String?
        public var expireDate: String?
        public var identityNumber: String?
    }
    
    // MARK: - Publics
    
    private(set) public var modelData: ModelData
    
    // MARK: - Privates
    
    private let mrzFirstLineRegex = "(I).([A-Z]{3})([A-Z0]{1})([0-9A-Z]{2})([A-Z0]{1})([0-9A-Z]+)([<]*)([0-9]+)([<=«]*)"
    private let mrzSecondLineRegex = "([0-9A-Z]+)([A-Z]{1})([0-9A-Z]+)([A-Z]{3})([<=«]*)([0-9]{1})"
    
    // MARK: - Initialization Methods
    
    public init(
        firstLine: [String],
        secondLine: [String]
    ) throws {
        self.modelData = ModelData()
        
        try parse(firstLine: firstLine)
        try parse(secondLine: secondLine)
    }
    
    // MARK: - Helper Methods
    
    private func parse(firstLine: [String]) throws {
        var isCompleted = false
        
        for line in firstLine {
            // Trim mrz
            let trimmedMRZ = line.replacingOccurrences(of: " ", with: "") as NSString
            let mrzCount = trimmedMRZ.length
            
            // Check length
            if mrzCount != 30 {
                continue
            }
            
            if let regex = try? NSRegularExpression(pattern: mrzFirstLineRegex, options: .caseInsensitive) {
                // Execute regex
                let matches = regex.matches(in: trimmedMRZ as String, range: NSRange(location: 0, length: mrzCount))
                
                // Check matches
                if matches.count != 1 {
                    continue
                }
                
                // Obtain result
                guard let result = matches.first else { return }
                var components = [String]()
                
                // Loop throught ranges
                for i in 0..<result.numberOfRanges {
                    // Obtain MRZ component
                    var component = trimmedMRZ.substring(with: result.range(at: i))
                    
                    // Check component index
                    if i == 3 || i == 5 {
                        component = component.replacingOccurrences(of: "0", with: "O")
                    }
                    if i == 4 || i == 6 || i == 8 {
                        component = component.replacingOccurrences(of: "O", with: "0")
                    }
                    
                    components.append(component)
                }
                
                // Create a document number
                var documentNumber = ""
                documentNumber += components[3]
                documentNumber += components[4]
                documentNumber += components[5]
                
                let componentSix = components[6]
                if componentSix.count >= 5 {
                    let trimmedComponentSix = componentSix.substring(start: 0, count: 5)
                    documentNumber += trimmedComponentSix
                }
                
                if checkDocumentNumber(documentNumber: documentNumber) {
                    modelData.documentNumber = documentNumber
                    modelData.identityNumber = components[8]
                    isCompleted = true
                    break
                }
            }
        }
        
        if !isCompleted {
            throw MRZError.parseError
        }
    }
    
    private func parse(secondLine: [String]) throws {
        var isCompleted = false
        
        for line in secondLine {
            // Trim mrz
            let trimmedMRZ = line.replacingOccurrences(of: " ", with: "") as NSString
            let mrzCount = trimmedMRZ.length
            
            // Check length
            if mrzCount != 30 {
                continue
            }
            
            if let regex = try? NSRegularExpression(pattern: mrzSecondLineRegex, options: .caseInsensitive) {
                // Execute regex
                let matches = regex.matches(in: trimmedMRZ as String, range: NSRange(location: 0, length: mrzCount))
                
                // Check matches
                if matches.count != 1 {
                    continue
                }
                
                // Obtain result
                guard let result = matches.first else { return }
                var components = [String]()
                
                // Loop throught ranges
                for i in 0..<result.numberOfRanges {
                    // Obtain MRZ component
                    var component = trimmedMRZ.substring(with: result.range(at: i))
                    
                    if i == 1 || i == 3 {
                        component = component.replacingOccurrences(of: "O", with: "0")
                    }
                    
                    components.append(component)
                }
                
                // Create a document number
                let birthDate = components[1].substring(start: 0, count: 6)
                let expireDate = components[3].substring(start: 0, count: 6)
                
                if checkDateFormat(dateString: birthDate) && checkDateFormat(dateString: expireDate) {
                    modelData.birthDate = birthDate
                    modelData.expireDate = expireDate
                    isCompleted = true
                    break
                }
            }
        }
        
        if !isCompleted {
            throw MRZError.parseError
        }
    }
    
    private func checkDocumentNumber(documentNumber: String) -> Bool {
        if documentNumber.count != 9 {
            return false
        }
        
        do {
            let regex = try NSRegularExpression(pattern: "^[A-Z]{1}[0-9]{2}[A-Z]{1}[0-9]{5}$", options: .caseInsensitive)
            let numberOfMatches = regex.numberOfMatches(in: documentNumber, range: NSRange(location: 0, length: documentNumber.count))
            
            if numberOfMatches != 1 {
                return false
            }
            
            return true
        } catch {
            return false
        }
    }
    
    private func checkDateFormat(dateString: String) -> Bool {
        if dateString.isEmpty {
            return false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        let date = dateFormatter.date(from: dateString)
        
        if date == nil {
            return false
        }
        
        return true
    }
}
