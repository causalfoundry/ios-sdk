//
//  BackendActionMainObject.swift
//
//
//  Created by Causal Foundry on 29.11.23.
//

import Foundation

// MARK: - BackendActionMainObject
public struct BackendActionMainObject: Codable, Hashable {
    var type: String
    var renderMethod: String
    var content: [String: String]
    var attr: [String: String]
    var internalObj: InternalObject

    public init(type: InvActionType, renderMethod: ActionRenderMethodType, content: [String: String], attr: [String: String], internalObj: InternalObject) {
        self.type = type.rawValue
        self.renderMethod = renderMethod.rawValue
        self.content = content
        self.attr = attr
        self.internalObj = internalObj
    }

    enum CodingKeys: String, CodingKey {
        case type
        case render_method
        case content
        case attr
        case internal_obj = "internal"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(String.self, forKey: .type)
        renderMethod = try values.decode(String.self, forKey: .render_method)
        content = try values.decode([String: String].self, forKey: .content)
        attr = try values.decode([String: String].self, forKey: .attr)
        internalObj = try values.decode(InternalObject.self, forKey: .internal_obj)
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(type, forKey: .type)
        try baseContainer.encode(renderMethod, forKey: .render_method)
        try baseContainer.encode(content, forKey: .content)
        try baseContainer.encode(attr, forKey: .attr)
        try baseContainer.encode(internalObj, forKey: .internal_obj)
    }
    
}


public struct InternalObject: Codable, Hashable {
    let expiredAt: String
    let refTime: String
    let modelId: String
    let invId: String
    let actionId: String
    
    var isExpired: Bool {
            guard expiredAt != "0001-01-01T00:00:00Z" else { return false }
        guard let date = ISO8601DateFormatter().date(from: expiredAt) else { return false }
            return Date().timeIntervalSince(date) > 0
        }

    public init(expiredAt : String, refTime : String, modelId : String, invId : String, actionId : String) {
        self.expiredAt = expiredAt
        self.refTime = refTime
        self.modelId = modelId
        self.invId = invId
        self.actionId = actionId
    }

    enum CodingKeys: String, CodingKey {
        case expired_at
        case ref_time
        case model_id
        case inv_id
        case action_id
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        expiredAt = try values.decode(String.self, forKey: .expired_at)
        refTime = try values.decode(String.self, forKey: .ref_time)
        modelId = try values.decode(String.self, forKey: .model_id)
        invId = try values.decode(String.self, forKey: .inv_id)
        actionId = try values.decode(String.self, forKey: .action_id)
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(expiredAt, forKey: .expired_at)
        try baseContainer.encode(refTime, forKey: .ref_time)
        try baseContainer.encode(modelId, forKey: .model_id)
        try baseContainer.encode(invId, forKey: .inv_id)
        try baseContainer.encode(actionId, forKey: .action_id)
    }
    
}
