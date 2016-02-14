//
//  GitHubRepositoryApiClient.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class GitHubRepositoryApiClient {
    
    let networkClient: NetworkClient
    var searchString: String!
    var nextPageUrl: String!

    convenience init() {
        self.init(networkClient: ApiClient())
    }
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    /**
     Fetch the GitHub Repositories by Language
     
     - parameter language:   Name of the language
     - parameter completion: Result
     */
    func fetchGitHubRepositoriesByLanguage(language: String, completion: ApiClientResult<[GitHubRepository]> -> Void) {
        
        let urlRequest:GitHubApiRouter
        // Next Page request call is initiated only if the search 
        // string matches with previous search
        if let nextPageUrl = nextPageUrl where searchString != nil && searchString == language {
            urlRequest = GitHubApiRouter.RepoSearchNextPage(searchUrl: nextPageUrl)
        } else {
            // Store the language, it will be used for next page search
            searchString = language
            urlRequest = GitHubApiRouter.RepoSearch(searchString: language)
        }
        
        let parse: (NSHTTPURLResponse, NSData) -> ApiClientResult<[GitHubRepository]> = {
            httpResponse, data in

            // Store the next search page url from the http response headers
            self.nextPageUrl = self.fecthLinks(httpResponse)
            
            do {
                if let jsonDict = try decodeJSON(data) {
                    if let items = jsonArray(jsonDict, key: "items") {
                        if let repositories = GitHubRepository.createGitHubRepositories(items) {
                            return .Success(repositories)
                        } else {
                            return .Failure(.JSONParseError)
                        }
                    }
                }
                return .Failure(.JSONParseError)
            } catch {
                return .Failure(.JSONParseError)
            }
        }
        
        let apiResource = ApiClientResource<[GitHubRepository]>(urlRequest: urlRequest, parse: parse)
        
        networkClient.apiRequest(apiResource) { (result) in
            completion(result)
        }
    }
    
    /**
     Fetch the Issues assoicated with the Repository
     
     - parameter repoUrl:    Repository Url
     - parameter completion: Result
     */
    func fetchOpenIssues(repoUrl: String, completion: ApiClientResult<[GitHubRepositoryIssue]> -> Void) {
        let urlRequest = GitHubApiRouter.RepoOpenIssues(repoUrl: repoUrl)
        
        let parse: (NSHTTPURLResponse, NSData) -> ApiClientResult<[GitHubRepositoryIssue]> = {
            httpResponse, data in
            
            do {
                if let jsonArray = try decodeJSONArrayDictionary(data) {
                    if let repoIssues = GitHubRepositoryIssue.createGitHubRepositoryIssues(jsonArray) {
                        return .Success(repoIssues)
                    } else {
                        return .Failure(.JSONParseError)
                    }
                }
            } catch {
                return .Failure(.JSONParseError)
            }
            return .Failure(.JSONParseError)
        }
        let apiResource = ApiClientResource<[GitHubRepositoryIssue]>(urlRequest: urlRequest, parse: parse)
        
        networkClient.apiRequest(apiResource) { (result) in
            completion(result)
        }
    }
    
    /**
     Fetch the Repository Contributors List
     
     - parameter contributorsUrl: Contributors List Url
     - parameter completion:      Result
     */
    func fetchRepoContibutors(contributorUrl: String, completion: ApiClientResult<[GitHubUser]> -> Void) {
        let urlRequest = GitHubApiRouter.RepoContibutors(contributorUrl: contributorUrl)
        let parse: (NSHTTPURLResponse, NSData) -> ApiClientResult<[GitHubUser]> = {
            httpResponse, data in
            
            do {
                if let jsonArray = try decodeJSONArrayDictionary(data) {
                    if let repoContributors = GitHubUser.createGitHubUsers(jsonArray) {
                        return .Success(repoContributors)
                    } else {
                        return .Failure(.JSONParseError)
                    }
                } else {
                    return .Failure(.JSONParseError)
                }
            } catch {
                return .Failure(.JSONParseError)
            }
        }
        let apiResource = ApiClientResource<[GitHubUser]>(urlRequest: urlRequest, parse: parse)
        
        networkClient.apiRequest(apiResource) { (result) in
            completion(result)
        }
    }
}

//MARK: Private Methods
extension GitHubRepositoryApiClient {
    
    // Parse the following string to extract the Next Search Page Url
    // Link = "<https://api.github.com/search/repositories?q=language%3Aswift&sort=stars&order=desc&per_page=10&page=2>; rel=\"next\", <https://api.github.com/search/repositories?q=language%3Aswift&sort=stars&order=desc&per_page=10&page=100>; rel=\"last\"";
    private func fecthLinks(httpResponse: NSHTTPURLResponse) -> String? {
        var nextPageUrl: String?
        // Extract the Link Value
        if let linkDetailString = httpResponse.allHeaderFields["Link"] as? String {
            // Split the LinkValue by ","
            let linkDetails = linkDetailString.componentsSeparatedByString(",")
            // Iterate each components
            for linkDetail in linkDetails {
                // Split the component by ";"
                let linkValues = linkDetail.componentsSeparatedByString(";")
                var link: String?
                // Itearte each linkValue components
                for linkValue in linkValues {
                    // Check for "next" and store the link
                    if linkValue == " rel=\"next\"" {
                        nextPageUrl = link?.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"))
                        break
                    } else {
                        link = linkValue
                    }
                }
            }
        }
        return nextPageUrl
    }
}