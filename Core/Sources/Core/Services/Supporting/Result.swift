//
//  Result.swift
//
//
//  Created by khushbu on 25/09/23.
//

import Foundation

/// The response from a method that can result in either a successful or failed state
public enum Result<T> {
    case success(T)
    case failure(Error)
}
