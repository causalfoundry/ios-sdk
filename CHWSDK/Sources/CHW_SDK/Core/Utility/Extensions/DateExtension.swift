//
//  File.swift
//  
//
//  Created by khushbu on 21/09/23.
//

import Foundation



extension Date {
    
    func convertMillisToTimeString(eventTime:Int64)-> String {
        var returnDate:String? = ""
        let dateFMT = DateFormatter()
        dateFMT.locale = Locale(identifier: "en_US_POSIX")
        dateFMT.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        if eventTime == 0   {
            //returnDate = dateFMT.s
            return returnDate ?? ""
        }else{
            return returnDate ?? ""
           // returnDate = dateFMT.string(from: Date().timeIntervalSince1970)
        }
        
    }
}
