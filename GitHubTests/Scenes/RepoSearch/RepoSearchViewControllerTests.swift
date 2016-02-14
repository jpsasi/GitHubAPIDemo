//
//  RepoSearchViewControllerTests.swift
//  GitHub
//
//  Created by Sasikumar JP on 14/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import XCTest
@testable import GitHub

class RepoSearchViewControllerTests: XCTestCase {
    
    // Subject Under Test
    var sut: RepoSearchViewController!
    var window: UIWindow!
    
    //MARK: Test Lifecycle Methods
    override func setUp() {
        super.setUp()
    
        window = UIWindow()
        setupRepoSearchViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }

    //MARK: Test setup
    func setupRepoSearchViewController() {
        let bundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewControllerWithIdentifier("RepoSearchViewController") as! RepoSearchViewController
    }
    
    func loadView() {
        print("loadView")
        window.addSubview(sut.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }
    
    //MARK: Test Doubles
    class RepoSearchPresenterSpy : RepoSearchPresenterInput {
        var loadRepositoryCalled: Bool = false
        
        func loadRepoWithLanguage(language: String) {
            loadRepositoryCalled = true
        }
    }
    
    class TableViewSpy : UITableView {
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    func testShouldLoadGitHubRepositoriesWhenViewIsLoaded() {
        // Given
        let presenterSpy = RepoSearchPresenterSpy()
        sut.presenter = presenterSpy
        
        // When
        loadView()
        
        // Then
        XCTAssert(presenterSpy.loadRepositoryCalled, "Should Load GitHubRepositories when view is loaded")
    }
    
    func testShouldDisplayFetchedRepositories() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        
        let viewModels = RepoSearchViewModel(repoName: "Swift", repoDescription: "Test Swift Repo", avatarUrl: "http://jpsasikumar.com", language: "swift", watchers: 100, forks: 100, stars: 100, repoUrl: "http://jpsasikumar.com", contributorUrl: "http://jpsasikumar.com")
        
        // When
        sut.showRepositories([viewModels])
        
        // Then
        XCTAssertTrue(tableViewSpy.reloadDataCalled, "Show Repositories should reload the TableView")
    }
    
    func testTableViewNumberOfSectionsToBeOne() {
        //Given
        loadView()
        let tableView = sut.tableView
        
        //When 
        let numberOfSections = sut.numberOfSectionsInTableView(tableView)
        
        XCTAssertEqual(numberOfSections, 1, "TableView number of sections should be one")
    }
}
