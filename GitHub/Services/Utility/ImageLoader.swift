//
//  ImageLoader.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class ImageLoader {
    
    let cache: NSCache
    let urlSession: NSURLSession
    let sessionConfig: NSURLSessionConfiguration

    class var sharedInstance: ImageLoader {
    
        struct Static {
            static var instance: ImageLoader?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ImageLoader()
        }
        return Static.instance!
    }

    init() {
        cache = NSCache()
        sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSession = NSURLSession(configuration: sessionConfig)
    }
    
    func loadImageInBackgroundWithUrl(imageUrl: String, completion: UIImage? -> ()) -> NSURLSessionDataTask? {
        if let encodedUrl = imageUrl.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet()) {
            if let url = NSURL(string: encodedUrl) {
                let task = urlSession.dataTaskWithURL(url, completionHandler: { (data, urlResponse, error) -> Void in
                    if let httpResponse = urlResponse as? NSHTTPURLResponse {
                        if let data = data where httpResponse.statusCode == 200 {
                            if let image = UIImage(data: data, scale: UIScreen.mainScreen().scale) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(image)
                                }
                            } else {
                                completion(nil)
                            }
                        } else {
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                })
                task.resume()
                return task
            }
            return nil
        }
        return nil
    }
}