//
//  ApiClient.swift
//  GitHub
//
//  Created by Sasikumar JP on 11/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

/**
 Enumeration to Hold the API Results
 
 - Success: Success Result
 - Failure: Failure Result with error code
 */
enum ApiClientResult<T> : CustomStringConvertible {
    case Success(T)
    case Failure(ApiClientError)
    
    var description: String {
        switch self {
        case .Success(let value):
            return "Success: \(value)"
        case .Failure(let apiError):
            return "Error: \(apiError)"
        }
    }
}

/**
 ApiClientError
 
 - Error:               Network Error
 - NotFound:            Resource Not Found
 - ServerError:         Server Error
 - ClientError:         Client Error
 - UnExpectedResponse:  UnExpected Response Error
 - JSONParseError:      JSON Parsing Error
 */
enum ApiClientError: ErrorType, CustomStringConvertible {
    case Error(NSError)
    case NotFound
    case ServerError(Int)
    case ClientError(Int)
    case UnExpectedResponse
    case JSONParseError
    
    var description: String {
        switch self {
        case Error(let error):
            return "Error: \(error.localizedDescription)"
        case NotFound:
            return "NotFound: Resource Not Available"
        case ServerError(let statusCode):
            return "ServiceError: \(statusCode)"
        case ClientError(let statusCode):
            return "ClientError: \(statusCode)"
        case UnExpectedResponse:
            return "UnExpectedResponse"
        case JSONParseError:
            return "JSONParseError"
        }
    }
}

/**
 *  Protocol to create the NSURLRequest
 */
protocol URLRequestConvertible {
    var urlRequest: NSMutableURLRequest { get }
}

/**
 *  APIResoure to handle the Network calls
 */
struct ApiClientResource<A> {
    let urlRequest: URLRequestConvertible
    let parse: (NSHTTPURLResponse, NSData) -> ApiClientResult<A>
}

/**
 *  Network Client Protocol
 */
protocol NetworkClient {
    func apiRequest<A>(resource: ApiClientResource<A>, completion: ApiClientResult<A> -> Void)
}

/// ApiClient which performs the Network Operation
class ApiClient : NetworkClient {
    
    let configuration: NSURLSessionConfiguration
    
    lazy var session: NSURLSession  = {
        return NSURLSession(configuration: self.configuration)
    }()
    
    convenience init() {
        self.init(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    }
    
    init(configuration: NSURLSessionConfiguration) {
        self.configuration = configuration
    }
    
    /**
     Perform the network operation
     
     - parameter resource:   Client Resource to trigger the network calls
     - parameter completion: Result
     */
    func apiRequest<A>(resource: ApiClientResource<A>, completion: ApiClientResult<A> -> Void) {
        var dataTask: NSURLSessionDataTask!
        dataTask = session.dataTaskWithRequest(resource.urlRequest.urlRequest) { (data, response, error) in
            if let error = error {
                completion(.Failure(ApiClientError.Error(error)))
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        if let data = data {
                            completion(resource.parse(httpResponse, data))
                        } else {
                            completion(.Failure(.UnExpectedResponse))
                        }
                    case 404:
                        completion(.Failure(.NotFound))
                    case 400...499:
                        completion(.Failure(.ClientError(httpResponse.statusCode)))
                    case 500...599:
                        completion(.Failure(.ServerError(httpResponse.statusCode)))
                    default:
                        completion(.Failure(.UnExpectedResponse))
                    }
                } else {
                    completion(.Failure(.UnExpectedResponse))
                }
            }
        }
        dataTask.resume()
    }    
}