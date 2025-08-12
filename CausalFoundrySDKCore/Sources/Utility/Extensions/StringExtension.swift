//
//  StringExtension.swift
//
//
//  Created by khushbu on 09/10/23.
//

import Foundation

extension String {
    func isNilOREmpty() -> Bool {
        if self == "" {
            return true
        } else {
            return false
        }
    }
    
    func toSnakeCase() -> String {
        return self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: " ", with: "_")
            .lowercased()
    }
}
