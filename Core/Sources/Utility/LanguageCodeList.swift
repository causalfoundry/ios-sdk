//
//  File.swift
//  
//
//  Created by khushbu on 09/10/23.
//

import Foundation
import UIKit

public enum LanguageCode: String,EnumComposable {
   
    
    case Afar = "Afar"
    case Abkhaz = "Abkhaz"
    case Avestan = "Avestan"
    // ... (all the other cases)

    // Custom properties with default valuesx
    var languageISO3Code: String? {
        switch self {
        case .Afar: return "AAR"
        case .Abkhaz: return "ABK"
        // ... (all the other cases)
        case .Avestan:
            return ""
        }
    }

    var languageISO2Code: String? {
        switch self {
        case .Afar: return "AA"
        case .Abkhaz: return "AB"
        // ... (all the other cases)
        case .Avestan:
            return ""
        }
    }

    var languageFullName: String? {
        switch self {
        case .Afar: return "Afar"
        case .Abkhaz: return "Abkhaz"
        // ... (all the other cases)
        case .Avestan:
            return ""
        }
    }

    // Custom initializer
    init?(languageISO3Code: String, languageISO2Code: String, languageFullName: String) {
        switch (languageISO3Code, languageISO2Code, languageFullName) {
        case ("AAR", "AA", "Afar"): self = .Afar
        case ("ABK", "AB", "Abkhaz"): self = .Abkhaz
        // ... (all the other cases)
        default: return nil
        }
    }
    
}


