//
//  RepoSearchInteractorTests.swift
//  GitHub
//
//  Created by Sasikumar JP on 14/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import XCTest
@testable import GitHub

class RepoSearchInteractorTests: XCTestCase {
    
    var sut: RepoSearchInteractor!
    let gitHubApiServiceMock = GitHubApiServiceMock()
    
    override func setUp() {
        super.setUp()
        
        setupInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func setupInteractor() {
        sut = RepoSearchInteractor(apiService: gitHubApiServiceMock)
    }
    
    // Test Doubles
    class GitHubApiServiceMock : GitHubApiService {
        var fetchGitHubRepositoriesInvoked = false
        
        override func fetchGitHubRepositoriesByLanguage(language: String, completion: ApiClientResult<[GitHubRepository]> -> Void) {

            fetchGitHubRepositoriesInvoked = true
            
            // Create dummy owner
            let owner = GitHubUser(userId: 1, login: "jpsasi", avatarUrl: "http://jpsasikumar.com", followersUrl: "http://jpsasikumar.com", followingUrl: "http://jpsasikumar.com")

            // Create dummy repository
            let repository = GitHubRepository(repositoryId: 1, name: "Swift", repoDescription: "Swift Project", createdAt: "1997", language: "Swift", watchers: 10, forks: 10, stars: 10, owner: owner, isPrivate: false, repoUrl: "http://jpsasikumar.com", contributorUrl: "http://jpsasikumar.com")

            // Send completion
            completion(ApiClientResult.Success([repository]))
        }
    }
    
    class RepoSearchPresenterSpy: RepoSearchInteractorOutput {
    
        var fetchedRepositoriesInvoked = false
        
        func fetchedRespositoriesResult(result: ApiClientResult<[GitHubRepository]>) {
            fetchedRepositoriesInvoked = true
        }
    }
    
    func testFetchGitHubRepositoriesShouldAskGitHubApiServiceToFetch() {
        // Given
        let presenterSpy = RepoSearchPresenterSpy()
        sut.output = presenterSpy

        // When
        sut.fetchRepoWithLanguage("")

        //Then
        XCTAssert(gitHubApiServiceMock.fetchGitHubRepositoriesInvoked, "Interactor FetchGitHubRepositories should call GitHubApiService to Fetch Repositories")
    }
    
    func testFetchGitHubRepositoriesShouldPassTheResultToPresenter() {
        
        // Given
        let presenterSpy = RepoSearchPresenterSpy()
        sut.output = presenterSpy
        
        // When 
        sut.fetchRepoWithLanguage("")
        
        let timeOutDate = NSDate(timeIntervalSinceNow: 5.0)
        while (!presenterSpy.fetchedRepositoriesInvoked && (timeOutDate.timeIntervalSinceNow > 0)) {
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, true)
        }
        
        // Then
        XCTAssert(presenterSpy.fetchedRepositoriesInvoked, "Interactor FetchGitHubRepositories should present the result to Presenter")
    }
}
