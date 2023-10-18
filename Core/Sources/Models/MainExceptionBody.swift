//
//  MainExceptionBody.swift
//
//
//  Created by khushbu on 18/10/23.
//

import Foundation


struct MainExceptionBody: Codable {
    var user_id: String?
    var device_info: DInfo?
    var app_info: AppInfo?
    var sdk_version: String?
    var data: [ExceptionDataObject]?
    
    static let encoder = JSONEncoder()
    
    init(user_id: String? = nil, device_info: DInfo? = nil, app_info: AppInfo? = nil, sdk_version: String? = nil, data: [ExceptionDataObject]? = nil) {
        self.user_id = user_id
        self.device_info = device_info
        self.app_info = app_info
        self.sdk_version = sdk_version
        self.data = data
    }
    
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MainExceptionBody.self, from: data)
    }
    
    private enum CodingKeys: String, CodingKey {
        case user_id = "u_id"
        case device_info = "d_info"
        case app_info = "app_info"
        case sdk_version = "sdk"
        case data
    }
    
    
    
    subscript(key: String) -> Any? {
            return dictionary[key]
        }
        var dictionary: [String: Any] {
            return (try? JSONSerialization.jsonObject(with: MainExceptionBody.encoder.encode(self))) as? [String: Any] ?? [:]
        }
    
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
}
