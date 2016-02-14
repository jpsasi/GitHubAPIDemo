//
//  GitHubRepository.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

/**
 *  Model to hold the GitHub Repository
 */
struct GitHubRepository : CustomStringConvertible {
    
    let repositoryId: Int
    let name: String            /* Respository Name */
    let repoDescription: String /* Repository Description */
    let createdAt: String      /* Created Date */
    let language: String       /* Programming Language */
    let watchers: Int
    let forks: Int
    let stars: Int
    let owner: GitHubUser
    let isPrivate: Bool
    let repoUrl: String
    let contributorUrl: String
    
    var description: String {
        return "Id: \(repositoryId) Name: \(name) owner: \(owner)\n"
    }
    
    /**
     Create the GitHubRepository from JSON Array
     
     - parameter repositories: repositories in JSON Array format
     - returns: GitHubRepository objects
     */
    static func createGitHubRepositories(repositories: [JSON]) -> [GitHubRepository]? {
        var gitHubRepositories: [GitHubRepository] = []
        for repository in repositories {
            if let gitHubRepository = fromJSON(repository) {
                gitHubRepositories.append(gitHubRepository)
            }
        }
        return gitHubRepositories.count > 0 ? gitHubRepositories : nil
    }
}

extension GitHubRepository : JSONParcelable {
    
    /**
     Parse the JSON to create the GitHubRepository Model
     
     - parameter json: JSON formatted GitHubRepository data
     
     - returns: GitHubRepository object
     */
    static func fromJSON(json: JSON) -> GitHubRepository? {
        guard
            let repoId = int(json, key: "id"),
            name = string(json, key: "name"),
            createdAt = string(json, key: "created_at"),
            language = string(json, key:"language"),
            watchers = int(json, key:"watchers_count"),
            forks = int(json, key:"forks"),
            stars = int(json, key: "stargazers_count"),
            owner = jsonValue(json, key:"owner"),
            repoDescription = string(json, key: "description"),
            isPrivate = bool(json, key: "private"),
            repoUrl = string(json, key: "url"),
            contributorUrl = string(json, key: "contributors_url") else {
                return nil
        }
        
        if let gitHubUser = GitHubUser.fromJSON(owner) {
            return GitHubRepository(repositoryId: repoId,
                                    name: name,
                                    repoDescription: repoDescription,
                                    createdAt: createdAt,
                                    language: language,
                                    watchers: watchers,
                                    forks: forks,
                                    stars: stars,
                                    owner: gitHubUser,
                                    isPrivate: isPrivate,
                                    repoUrl: repoUrl,
                                    contributorUrl: contributorUrl)
        }
        return nil
    }
}