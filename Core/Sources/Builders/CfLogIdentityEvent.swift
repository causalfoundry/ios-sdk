//
//  CfLogIdentityEvent.swift
//
//
//  Created by khushbu on 28/09/23.
//

import Foundation

/**
 * CfLogIdentityEvent is required to log events related user login and register.
 * Identity events are divided into 3 events:
 * register: after successful signup/register.
 * login: after successful login.
 * logout: after successful logout.
 */


class CfLogIdentityEvent  {
     var identity_action:String = ""
     var app_user_id:String = ""
     var meta:Any?
     var update_immediately:Bool = CoreConstants.shared.updateImmediately
    
    init(identity_action: String, app_user_id: String, meta: Any? = nil, update_immediately: Bool) {
        self.identity_action = identity_action
        self.app_user_id = app_user_id
        self.meta = meta
        self.update_immediately = update_immediately
    }
}


class CfLogIdnetityBuilder {
    private var identity_action:String = ""
    private var app_user_id:String = ""
    private var meta:Any?
    private var update_immediately:Bool = CoreConstants.shared.updateImmediately

    init() {
        
}
    
    
    /**
     * setIdentifyAction is used to specify the identify action for the User,
     * it can register in case of signup and registration
     * it can be login in case of returning user
     * it can be logout in case if the user is logging out of the app.
     * identity action can be provided by using 2 approaches, one is by using the SDK provided
     * enums and the other is by using string. Usage of enum is appreciated. Below is the
     * function provided for the enum based usage.
     *
     */
    func setIdentifyAction(identity_action: IdentityAction) -> CfLogIdnetityBuilder {
        self.identity_action = identity_action.rawValue
        return self
    }
    
    /**
     * setIdentifyAction is used to specify the identify action for the User,
     * it can register in case of signup and registration
     * it can be login in case of returning user
     * it can be logout in case if the user is logging out of the app.
     * identity action can be provided by using 2 approaches, one is by using the SDK provided
     * enums and the other is by using string. Usage of enum is appreciated. Below is the
     * function provided for the string based usage. Remember to use the same strings as
     * provided in the enums or else the event will be discarded.
     */
    func setIdentifyAction(identity_action: String) -> CfLogIdnetityBuilder {
        return self
        
    }
    
    /**
     * setAppUserId is required to identify the user based on the userID. You only need to
     * provide this Id once and afterwards the SDK will be responsible for storing and passing
     * the userID with log events. One important thinbb g to note here is that calling the logout
     * action will remove any data stored by the SDK including the userID but only after
     * successfully uploading the existing data to the backend.
     */
    func setAppUserId(app_user_id: String) -> CfLogIdnetityBuilder{
        self.app_user_id = app_user_id
        return self
    }
    
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    func setMeta(meta: Any?) -> CfLogIdnetityBuilder{
        self.meta = meta
        return self
    }
    
    /**
     * updateImmediately is responsible for updating the values ot the backend immediately.
     * By default this is set to false or whatever the developer has set in the SDK
     * initialisation block. This differs the time for which the logs will be logged, if true,
     * the SDK will log the content instantly and if false it will wait till the end of user
     * session which is whenever the app goes into background.
     */
    func updateImmediately(update_immediately: Bool)  -> CfLogIdnetityBuilder{
        self.update_immediately = update_immediately
        return self
    }
    
    func setCountry(country:String?) ->  CfLogIdnetityBuilder {
        if country == "" {
            
        }
        return self
        
    }
    
    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    
    func build() {
        
    }
    
}
