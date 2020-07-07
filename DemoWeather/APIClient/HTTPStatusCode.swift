//
//  HTTPStatusCode.swift
//  DemoWeather
//
//  Created by admin on 03/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

enum HTTPStatusCode: Int {
  
  // MARK: - Success Codes
  
  case oK = 200
  case created = 201
  case accepted = 202
  case nonAuthoritativeInformation = 203
  case noContent = 204
  case resetContent = 205
  case partialContent = 206
  case multiStatus = 207
  case alreadyReported = 208
  case IMUsed = 209
  
  // MARK: - Client Error
  
  case badRequest = 400
  case unauthorised = 401
  case paymentRequired = 402
  case forbidden = 403
  case notFound = 404
  case methodNotAllowed = 405
  case notAcceptable = 406
  case proxyAuthenticationRequired = 407
  case requestTimeout = 408
  case conflict = 409
  case gone = 410
  case lengthRequired = 411
  case preconditionFailed = 412
  case requestEntityTooLarge = 413
  case requestURITooLong = 414
  case unsupportedMediaType = 415
  case requestedRangeNotSatisfiable = 416
  case expectationFailed = 417
  case iamATeapot = 418
  case authenticationTimeout = 419
  case methodFailureSpringFramework = 420
  case enhanceYourCalmTwitter = 4200
  case unprocessableEntity = 422
  case locked = 423
  case failedDependency = 424
  case methodFailureWebDaw = 4240
  case unorderedCollection = 425
  case upgradeRequired = 426
  case preconditionRequired = 428
  case tooManyRequests = 429
  case requestHeaderFieldsTooLarge = 431
  case noResponseNginx = 444
  case retryWithMicrosoft = 449
  case blockedByWindowsParentalControls = 450
  case redirectMicrosoft = 451
  case unavailableForLegalReasons = 4510
  case requestHeaderTooLargeNginx = 494
  case certErrorNginx = 495
  case noCertNginx = 496
  case HTTPToHTTPSNginx = 497
  case clientClosedRequestNginx = 499
  
  // MARK: - Server Error
  
  case internalServerError = 500
  case notImplemented = 501
  case badGateway = 502
  case serviceUnavailable = 503
  case gatewayTimeout = 504
  case hTTPVersionNotSupported = 505
  case variantAlsoNegotiates = 506
  case insufficientStorage = 507
  case loopDetected = 508
  case bandwidthLimitExceeded = 509
  case notExtended = 510
  case networkAuthenticationRequired = 511
  case connectionTimedOut = 522
  case networkReadTimeoutErrorUnknown = 598
  case networkConnectTimeoutErrorUnknown = 599
  
  case undefined = 99999999
  
  // MARK: - Response Type
  
  enum ResponseType {
    
    case success
    case clientError
    case serverError
    case undefined
  }
  
  var responseType: ResponseType {
    
    switch self.rawValue {
    case 200..<300:
      return .success
    case 400..<500:
      return .clientError
      
    case 500..<600:
      return .serverError
      
    default:
      return .undefined
    }
  }
}
