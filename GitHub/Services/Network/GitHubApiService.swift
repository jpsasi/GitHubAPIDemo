//
//  GitHubApiService.swift
//  GitHub
//
//  Created by Sasikumar JP on 11/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class GitHubApiService {
    
    lazy var repositoryApiClient: GitHubRepositoryApiClient = {
        return GitHubRepositoryApiClient()
    }()
    
    /// Singletone Instance
    static var sharedInstance: GitHubApiService {
        
        struct Static {
            static var instance: GitHubApiService?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = GitHubApiService()
        }
        return Static.instance!
    }
    
    /**
     Fetch the GitHub Repositories by Language
     
     - parameter language:   Name of the language
     - parameter completion: Result
     */
    func fetchGitHubRepositoriesByLanguage(language: String, completion: ApiClientResult<[GitHubRepository]> -> Void) {
        
        repositoryApiClient.fetchGitHubRepositoriesByLanguage(language, completion: completion)
    }
    
    /**
     Fetch the Issues assoicated with the Repository
     
     - parameter repoUrl:    Repository Url
     - parameter completion: Result
     */
    func fetchRepositoryOpenIssues(repoUrl: String, completion: ApiClientResult<[GitHubRepositoryIssue]> -> Void) {
        repositoryApiClient.fetchOpenIssues(repoUrl, completion: completion)
    }
    
    /**
     Fetch the Repository Contributors List
     
     - parameter contributorsUrl: Contributors List Url
     - parameter completion:      Result
     */
    func fetchRepoContibutors(contributorsUrl: String, completion: ApiClientResult<[GitHubUser]> -> Void) {
        repositoryApiClient.fetchRepoContibutors(contributorsUrl, completion: completion)
    }
}