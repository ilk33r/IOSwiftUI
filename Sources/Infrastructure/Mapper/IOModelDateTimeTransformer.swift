//
//  IOModelDateTimeTransformer.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import IOSwiftUICommon

public final class IOModelDateTimeTransformer: IOModelTransformer {
    
    // MARK: - Privates
    
    private var dateFormat: String
    
    // MARK: - Initialization Methods
    
    public init(dateFormat: String) {
        self.dateFormat = dateFormat
    }
    
    // MARK: - Transformer Methods
    
    public func toJSONString<TType: Any>(data: TType) -> String? {
        guard let date = data as? Date else { return nil }
                
        // Obtain date formatter
        let formatter = self.dateFormatter()
        
        // Format value
        return formatter.string(from: date)
    }
    
    public func fromJSONString<TType: Any>(string: String?) -> TType? {
        guard let dateString = string else { return nil }
                
        // Obtain date formatter
        let formatter = self.dateFormatter()
        
        // Create formatted date
        let dateStringWithoutMilliseconds = self.stripMillisecondsFromDateString(dateString: dateString)
        return formatter.date(from: dateStringWithoutMilliseconds) as? TType
    }
    
    // MARK: - Helper Methods
    
    private func dateFormatter() -> DateFormatter {
        // Create date formatter
        let dateTimeFormatter = DateFormatter()
        
        // Update locale and timezone
        dateTimeFormatter.locale = Locale.current
        dateTimeFormatter.timeZone = TimeZone.current
        
        // Set date format
        dateTimeFormatter.dateFormat = self.dateFormat
        
        return dateTimeFormatter
    }
    
    private func stripMillisecondsFromDateString(dateString: String) -> String {
        // Create regex for milliseconds
        let regexPattern = "\\.([0-9]+)\\+"
        let regex = try? NSRegularExpression(pattern: regexPattern, options: .init(rawValue: 0))
        let searchedRange = NSRange(location: 0, length: dateString.count)
        let matches = regex?.matches(in: dateString, options: .init(rawValue: 0), range: searchedRange)
        
        // Check milliseconds exists
        if matches?.count ?? 0 > 0, let result = matches?.first {
            // Obtain regex result
            let dateNSString = dateString as NSString
            let milliseconds = dateNSString.substring(with: result.range)
            
            // Remove milliseconds
            return dateString.replacingOccurrences(of: milliseconds, with: "+")
        }
        
        return dateString
    }
}
