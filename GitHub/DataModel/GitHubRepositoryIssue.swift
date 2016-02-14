//
//  GitHubRepositoryIssue.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

/**
 *  Model to hold the Issue detail
 */
struct GitHubRepositoryIssue : CustomStringConvertible {
    let issueId: Int
    let issueNumber: Int
    let title: String
    let issueUrl: String
    let state: String
    let body: String
    let createdDate: NSDate?
    let updatedDate: NSDate?
    
    var description: String {
        return "\(issueNumber)|\(title)|\(body)"
    }
    
    /**
     Create the GitHubRepository Issues from JSON Array
     
     - parameter issues: issues in JSON Array format
     - returns: GitHubRepositoryIssue objects
     */
    static func createGitHubRepositoryIssues(issues: [JSON]) -> [GitHubRepositoryIssue]? {
        var repoIssues = [GitHubRepositoryIssue]()
        
        for issue in issues {
            if let repoIssue = fromJSON(issue) {
                repoIssues.append(repoIssue)
            }
        }
        return repoIssues.count > 0 ? repoIssues : nil
    }
}

extension GitHubRepositoryIssue : JSONParcelable {
    
    /**
     Parse the JSON to create the GitHubRepositoryIssue Model
     
     - parameter json: JSON formatted GitHubRepositoryIssue data
     
     - returns: GitHubRepositoryIssue object
     */
    static func fromJSON(json: JSON) -> GitHubRepositoryIssue? {
        guard let issueId = int(json, key: "id"),
            number = int(json, key: "number"),
            title = string(json, key: "title"),
            issueUrl = string(json, key: "url"),
            state = string(json, key: "state"),
            body = string(json, key: "body"),
            createdAt = string(json, key: "created_at"),
            updatedAt = string(json, key: "updated_at") else {
            return nil
        }
        
        let createdDate = createdAt.iso8601StringToDate()
        let updatedDate = updatedAt.iso8601StringToDate()
        return GitHubRepositoryIssue(issueId: issueId, issueNumber: number, title: title, issueUrl: issueUrl, state: state, body: body, createdDate: createdDate, updatedDate: updatedDate)
    }
}