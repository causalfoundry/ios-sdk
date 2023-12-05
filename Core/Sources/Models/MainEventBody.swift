

import Foundation

// MARK: - MainBody
struct MainBody: Codable {
    
    let sID, uID: String
    let appInfo: AppInfo
    let dInfo: DInfo
    let dn: Int
    let sdk: String
    let up: Int
    let data: [EventDataObject]

    enum CodingKeys: String, CodingKey {
        case sID = "s_id"
        case uID = "u_id"
        case appInfo = "app_info"
        case dInfo = "d_info"
        case dn, sdk, up
        case data  = "data"
    }
}

// MARK: - Props
struct Props: Codable {
    
    let action: String?
    let duration: Double?
    let path, title: String?
}

// MARK: - Helper functions for creating encoders and decoders

public extension JSONEncoder {
    
    static var new: JSONEncoder = {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }()
}

public extension JSONDecoder {
    
    static var new: JSONDecoder = {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }()
}
