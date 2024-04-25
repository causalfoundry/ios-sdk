//
//  NudgeUtils.swift
//
//
//  Created by Causal Foundry on 30.11.23.
//

import Foundation

extension NSAttributedString {
    static func fromHTML(_ htmlString: String) -> NSAttributedString? {
        guard let data = htmlString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html],
                                          documentAttributes: nil)
        } catch {
            print("Error converting HTML string to attributed string: \(error)")
            return nil
        }
    }
}
