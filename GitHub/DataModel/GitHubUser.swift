//
//  GitHubUser.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

/**
 *  Model to hold the GitHub User detail
 */
struct GitHubUser : CustomStringConvertible {
    let userId: Int
    let login: String
    let avatarUrl: String
    let followersUrl: String
    let followingUrl: String
    
    var description: String {
        return "UserId: \(userId) Login: \(login)"
    }
    
    /**
     Create the GitHubUsers from JSON Array
     
     - parameter users: Users in JSON Array format
     - returns: GitHubUser objects
     */
    static func createGitHubUsers(users: [JSON]) -> [GitHubUser]? {
        var gitHubUsers: [GitHubUser] = []
        
        for user in users {
            if let gitHubUser = fromJSON(user) {
                gitHubUsers.append(gitHubUser)
            }
        }
        return gitHubUsers.count > 0 ? gitHubUsers : nil
    }
}

extension GitHubUser : JSONParcelable {
    
    /**
     Parse the JSON to create the GitHubUser Model
     
     - parameter json: JSON formatted GitHubUser data
     
     - returns: GitHubUser object
     */
    static func fromJSON(json: JSON) -> GitHubUser? {
        guard
            let avatarUrl = string(json, key: "avatar_url"),
            login = string(json, key: "login"),
            userId = int(json, key: "id"),
            followersUrl = string(json, key: "followers_url"),
            followingUrl = string(json, key: "following_url") else {
            return nil
        }
        return GitHubUser(userId: userId, login: login, avatarUrl: avatarUrl, followersUrl: followersUrl, followingUrl: followingUrl)
    }
}