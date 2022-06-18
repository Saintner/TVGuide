//
//  TVGError.swift
//  TVGuide
//
//  Created by Eris Martinez on 17/06/22.
//

import Foundation
// A base error Enum with a map method
enum TVGError: Error {
  case statusCode
  case decoding
  case invalidURL
  case other(Error)
  
  static func map(_ error: Error) -> TVGError {
    return (error as? TVGError) ?? .other(error)
  }
}
