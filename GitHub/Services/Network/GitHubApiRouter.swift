//
//  GitHubApiRouter.swift
//  GitHub
//
//  Created by Sasikumar JP on 11/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

enum GitHubApiRouter : URLRequestConvertible {
    
    static let baseURLString = "https://api.github.com"
    
    case RepoSearch(searchString: String)
    case RepoSearchNextPage(searchUrl: String)
    case RepoOpenIssues(repoUrl: String)
    case RepoContibutors(contributorUrl: String)
    
    var path: String {
        switch self {
        case .RepoSearch(let searchString):
            return "\(GitHubApiRouter.baseURLString)/search/repositories?q=language:\(searchString)&sort=stars&order=desc&per_page=20".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
        case .RepoSearchNextPage(let searchUrl):
            return searchUrl
        case .RepoOpenIssues(let repoUrl):
            return "\(repoUrl)/issues"
        case .RepoContibutors(let contributorUrl):
            return contributorUrl
        }
    }
    
    var urlRequest: NSMutableURLRequest {
        let mutableRequest = NSMutableURLRequest(URL: NSURL(string:path)!)
        mutableRequest.HTTPMethod = "GET"
        return mutableRequest
    }
}