

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
    
    static let encoder = JSONEncoder()
    

    enum CodingKeys: String, CodingKey {
        case sID = "s_id"
        case uID = "u_id"
        case appInfo = "app_info"
        case dInfo = "d_info"
        case dn, sdk, up
        case data  = "data"
    }
}

// MARK: MainBody convenience initializers and mutators

extension MainBody {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MainBody.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    
    subscript(key: String) -> Any? {
            return dictionary[key]
        }
        var dictionary: [String: Any] {
            return (try? JSONSerialization.jsonObject(with: MainBody.encoder.encode(self))) as? [String: Any] ?? [:]
        }
    
    func with(
        sID: String? = nil,
        uID: String? = nil,
        appInfo: AppInfo? = nil,
        dInfo: DInfo? = nil,
        dn: Int? = nil,
        sdk: String? = nil,
        up: Int? = nil,
        data: [EventDataObject]? = nil
    ) -> MainBody {
        return MainBody(
            sID: sID ?? self.sID,
            uID: uID ?? self.uID,
            appInfo: appInfo ?? self.appInfo,
            dInfo: dInfo ?? self.dInfo,
            dn: dn ?? self.dn,
            sdk: sdk ?? self.sdk,
            up: up ?? self.up,
            data: data ?? self.data
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}





// MARK: - Props
struct Props: Codable {
    let action: String?
    let duration: Double?
    let path, title: String?
}

// MARK: Props convenience initializers and mutators

extension Props {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Props.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        action: String?? = nil,
        duration: Double?? = nil,
        path: String?? = nil,
        title: String?? = nil
    ) -> Props {
        return Props(
            action: action ?? self.action,
            duration: duration ?? self.duration,
            path: path ?? self.path,
            title: title ?? self.title
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

