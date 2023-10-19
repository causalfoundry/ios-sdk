//
//  File.swift
//  
//
//  Created by khushbu on 09/10/23.
//
import Foundation


class ExceptionError: Error {
    init() {
        
    }

    init(message: String) {
       
    }

    init(message: String, cause: Error) {
       
    }

    init(cause: Error) {
        
    }

    init(message: String, cause: Error?, enableSuppression: Bool, writableStackTrace: Bool) {
       
    }
    
    required init?(coder: NSCoder) {
        
    }
}


 class IllegalArgumentException: ExceptionError {
     var message: String = "Illegal Argument"

    public override init() {
        super.init()
       
    }

    public init(_ message: String) {
        super.init(message: message)
        self.message = message
    }

    public override init(message: String, cause: Error) {
        super.init(message: message, cause: cause)
        self.message = message + ": " + cause.localizedDescription
    }

    public override init(cause: Error) {
        super.init(cause: cause)
        self.message = cause.localizedDescription
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IllegalStateException: ExceptionError {
    var message: String  = "Illegal State"
    var line:String?
    var className:String?
    
    public override init() {
        super.init()
    }
    
    public init(_ message: String) {
        super.init(message: message)
        self.message = message
    }
    
    public override init(message: String, cause: Error) {
        super.init(message:message, cause: cause)
        self.message = message + ": " + cause.localizedDescription
    }
    
    public override init(cause: Error) {
        super.init(cause: cause)
        self.message = cause.localizedDescription
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NullPointerException: ExceptionError {
    var message: String = "Null Pointer Exception"

    public override init() {
        super.init()
    }

    public init(_ message: String) {
        super.init(message: message)
        self.message = message
    }

    public override init(message: String, cause: Error) {
        super.init(message: message, cause: cause)
        self.message = message + ": " + cause.localizedDescription
    }

    public override init(cause: Error) {
        super.init(cause: cause)
        self.message = cause.localizedDescription
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class RuntimeException: ExceptionError {
    var message: String = "RunTime Exception"

    override init() {
        super.init()
    }

    init(_ message: String) {
        super.init(message: message)
        self.message = message
    }

    init(_ message: String, cause: Error?) {
        // Ignoring cause for simplicity in this example
        super.init(message: message, cause: cause!)
        self.message = message
    }

    override init(cause: Error?) {
        super.init(cause: cause!)
        // Ignoring cause for simplicity in this example
        self.message = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


