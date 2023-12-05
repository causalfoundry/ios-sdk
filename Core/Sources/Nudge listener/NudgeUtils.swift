//
//  File.swift
//  
//
//  Created by Causal Foundry on 30.11.23.
//


import Foundation

class NudgeUtils {
    
    static func getBodyTextBasedOnTemplate(nudgeObjectString: String) -> String {
        return getBodyTextBasedOnTemplate(
            nudgeObject: try! JSONDecoder.new.decode(BackendNudgeMainObject.self, from: nudgeObjectString.data(using: .utf8)!)
        )
    }
    
    static func getBodyTextBasedOnTemplate(nudgeObject: BackendNudgeMainObject) -> String {
        if nudgeObject.nd.message?.tmplCFG == nil {
            // simple push notification
            return checkBodyForTemplatePlaceholders(nudgeObject: nudgeObject)
        } else {
            switch nudgeObject.nd.message?.tmplCFG!.tmplType {
            case "":
                // simple push notification
                return checkBodyForTemplatePlaceholders(nudgeObject: nudgeObject)
            default:
                let templateTypes = nudgeObject.nd.message?.tmplCFG!.tmplType?.split(separator: ",").map { String($0) } ?? []
                var bodyText = nudgeObject.nd.message?.body ?? ""
                for tmplType in templateTypes {
                    if tmplType.trimmingCharacters(in: .whitespaces) == BackendNudgeMainObject.Extra.CodingKeys.itemPair.rawValue {
                        // item pair notification
                        bodyText = validateAndProvideItemPairString(inputString: bodyText, nudgeObject: nudgeObject)
                    } else if tmplType.trimmingCharacters(in: .whitespaces) == BackendNudgeMainObject.Extra.CodingKeys.traits.rawValue {
                        // traits notification
                        bodyText = validateAndProvideTraitsString(inputString: bodyText, nudgeObject: nudgeObject)
                    } else {
                        ExceptionManager.throwInvalidNudgeException(message: "Invalid tmpl_cfg.tmpl_type provided", nudgeObject: nudgeObject.prettyJSON)
                        bodyText = ""
                    }
                }
                return bodyText
            }
        }
    }
    
    private static func checkBodyForTemplatePlaceholders(nudgeObject: BackendNudgeMainObject) -> String {
        let body = nudgeObject.nd.message?.body ?? ""
        let regex = try! NSRegularExpression(pattern: "\\{\\{\\s*(.*?)\\s*\\}\\}")
        if regex.firstMatch(in: body, range: NSRange(body.startIndex..., in: body)) != nil {
            ExceptionManager.throwInvalidNudgeException(message: "Empty Template Type but body contains placeholders", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        return body
    }
    
    private static func validateAndProvideTraitsString(inputString: String, nudgeObject: BackendNudgeMainObject) -> String {
        guard let traitsCfg = nudgeObject.nd.message?.tmplCFG?.traits else {
            ExceptionManager.throwInvalidNudgeException(message: "Invalid tmpl_cfg.traits provided", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        guard let extra = nudgeObject.extra else {
            ExceptionManager.throwInvalidNudgeException(message: "Invalid extra provided", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        guard let traitsExtraObject = extra.traits else {
            ExceptionManager.throwInvalidNudgeException(message: "Invalid extra.traits provided", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        guard !traitsExtraObject.isEmpty else {
            ExceptionManager.throwInvalidNudgeException(message: "Empty extra.traits provided", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        
        var traitsMap: [String: Any] = [:]
        if let jsonData = traitsExtraObject.toData() {
            do {
                traitsMap = try JSONSerialization.jsonObject(with: jsonData) as! [String: Any]
            } catch {
                ExceptionManager.throwInvalidNudgeException(message: "Failed to parse extra.traits JSON", nudgeObject: nudgeObject.prettyJSON)
                return ""
            }
        }
        
        if traitsCfg.count != traitsMap.count {
            ExceptionManager.throwInvalidNudgeException(message: "extra.traits and tmpl_cfg.traits size mismatch", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        
        for trait in traitsCfg {
            if !traitsMap.keys.contains(trait) {
                ExceptionManager.throwInvalidNudgeException(message: "extra.traits and tmpl_cfg.traits values mismatch", nudgeObject: nudgeObject.prettyJSON)
                return ""
            }
        }
        
        var nudgeObjectBody = inputString
        for (key, value) in traitsMap {
            nudgeObjectBody = nudgeObjectBody.replacingOccurrences(of: "{{\(key)}}", with: "\(value)")
            nudgeObjectBody = nudgeObjectBody.replacingOccurrences(of: "{{ \(key) }}", with: "\(value)")
        }
        return nudgeObjectBody
    }
    
    private static func validateAndProvideItemPairString(inputString: String, nudgeObject: BackendNudgeMainObject) -> String {
        guard let itemPairCfg = nudgeObject.nd.message?.tmplCFG?.itemPairCFG else {
            ExceptionManager.throwInvalidNudgeException(message: "Invalid tmpl_cfg.item_pair_cfg provided", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        guard let extra = nudgeObject.extra else {
            ExceptionManager.throwInvalidNudgeException(message: "Invalid extra provided", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        guard let itemPairExtraObject = extra.itemPair else {
            ExceptionManager.throwInvalidNudgeException(message: "Invalid extra.item_pair provided", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        guard itemPairExtraObject.names?.count == 2 else {
            ExceptionManager.throwInvalidNudgeException(message: "Invalid extra.item_pair.names values provided", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        guard itemPairExtraObject.ids?.count == 2 else {
            ExceptionManager.throwInvalidNudgeException(message: "Invalid extra.item_pair.ids values provided", nudgeObject: nudgeObject.prettyJSON)
            return ""
        }
        
        var nudgeObjectBody = inputString
        nudgeObjectBody = nudgeObjectBody.replacingOccurrences(of: "{{ primary }}", with: "\(itemPairExtraObject.names![0])")
        nudgeObjectBody = nudgeObjectBody.replacingOccurrences(of: "{{primary}}", with: "\(itemPairExtraObject.names![0])")
        nudgeObjectBody = nudgeObjectBody.replacingOccurrences(of: "{{ secondary }}", with: "\(itemPairExtraObject.names![1])")
        nudgeObjectBody = nudgeObjectBody.replacingOccurrences(of: "{{secondary}}", with: "\(itemPairExtraObject.names![1])")
        
        return nudgeObjectBody
    }
}
