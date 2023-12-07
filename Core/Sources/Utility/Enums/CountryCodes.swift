import Foundation

public enum CountryCode: String, EnumComposable, CaseIterable {
    static var allValues: [CountryCode] = CountryCode.allValues

    case Ascension_Island = "ASC"
    case Andorra = "AND"
    case United_Arab_Emirates = "ARE"
    // ... (add other cases similarly)

    // Custom properties with default values
    var countryISO3Code: String? {
        switch self {
        case .Ascension_Island:
            return "AC"
        case .Andorra:
            return "AD"
        // ... (add cases similarly)
        case .United_Arab_Emirates:
            return "ARE"
        }
    }

    var countryISO2Code: String? {
        switch self {
        case .Ascension_Island:
            return "Ascension_Island"
        case .Andorra:
            return "Andorra"
        case .United_Arab_Emirates:
            return "AE"
            // ... (add cases similarly)
        }
    }

    var countryFullName: String? {
        switch self {
        case .Ascension_Island:
            return "Ascension_Island"
        case .Andorra:
            return "Andorra"
        case .United_Arab_Emirates:
            return "United Arab Emirates"
            // ... (add cases similarly)
        }
    }

    // Custom initializer
    init?(countryISO3Code: String, countryISO2Code _: String, countryFullName _: String) {
        switch countryISO3Code {
        case "ASC":
            self = .Ascension_Island
        case "AND":
            self = .Andorra
        case "ARE":
            self = .United_Arab_Emirates
        // ... (add cases similarly)

        default:
            return nil
        }
    }
}
