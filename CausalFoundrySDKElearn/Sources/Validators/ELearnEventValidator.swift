//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class ELearnEventValidator {
    
    static func validateModuleObject<T: Codable>(logObject: T?) -> ModuleObject? {
        guard let eventObject = logObject as? ModuleObject else {
            ExceptionManager.throwInvalidException(
                eventType: ELearnEventType.Module.rawValue,
                paramName: "ModuleObject",
                className: "ModuleObject"
            )
            return nil
        }
        
        if(eventObject.id.isEmpty) {
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.Module.rawValue, elementName: "module_id")
            return nil
        }
        
        return eventObject
    }
    
    static func validateExamObject<T: Codable>(logObject: T?) -> ExamObject? {
        guard let eventObject = logObject as? ExamObject else {
            ExceptionManager.throwInvalidException(
                eventType: ELearnEventType.Exam.rawValue,
                paramName: "ExamObject",
                className: "ExamObject"
            )
            return nil
        }
        
        if(eventObject.id.isEmpty) {
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.Exam.rawValue, elementName: "exam_id")
            return nil
        }else if(eventObject.action == ExamAction.Submit.rawValue && eventObject.duration == nil){
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.Exam.rawValue, elementName: "duration_value")
            return nil
        }else if(eventObject.action == ExamAction.Result.rawValue && eventObject.score == nil){
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.Exam.rawValue, elementName: "score")
            return nil
        }else if(eventObject.action == ExamAction.Result.rawValue && eventObject.isPassed == nil){
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.Exam.rawValue, elementName: "is_passed")
            return nil
        }
        return eventObject
    }
    
    static func validateQuestionObject<T: Codable>(logObject: T?) -> QuestionObject? {
        guard let eventObject = logObject as? QuestionObject else {
            ExceptionManager.throwInvalidException(
                eventType: ELearnEventType.Question.rawValue,
                paramName: "QuestionObject",
                className: "QuestionObject"
            )
            return nil
        }
        
        if(eventObject.id.isEmpty) {
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.Question.rawValue, elementName: "question_id")
            return nil
        }else if(eventObject.examId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.Question.rawValue, elementName: "exam_id")
            return nil
        }else if(eventObject.action == QuestionAction.Answer.rawValue && eventObject.answerId?.isEmpty ?? true){
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.Question.rawValue, elementName: "answer_id")
            return nil
        }
        return eventObject
    }
}
