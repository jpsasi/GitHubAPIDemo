//
//  RepoSearchViewController.swift
//  GitHub
//
//  Created by Sasikumar JP on 11/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    var presenter: RepoSearchPresenterInput!
    
    var repoSearchViewModels: [RepoSearchViewModel] = []
    var filteredResults: [RepoSearchViewModel] = []
    var repoSearchConfigurator = RepoSearchConfigurator()
    var filterLanguage: String? {
        didSet {
            updateTitle()
        }
    }
    
    struct Constants {
        static let LoadingTableViewCellTag = 1000
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        repoSearchConfigurator.configure(self)
    }
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableViewAutomaticDimension
        
        setupSearchView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateTitle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action Methods
    @IBAction func showFilterDialog(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Repository Filter", message: "Please Enter the Language", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Programming Language"
            if let selectedLanguage = self.filterLanguage {
                textField.text = selectedLanguage
            }
        }
        
        let filterAction = UIAlertAction(title: "Filter", style: UIAlertActionStyle.Default) { action in
            if let textField = alertController.textFields?.first {
                self.filterLanguage = textField.text
                
                // Clear the existing viewModels
                self.repoSearchViewModels.removeAll()
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { action in
        }
        
        alertController.addAction(filterAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier, cell = sender as? UITableViewCell {
            if identifier == "RepoDetailSegue" {
                let detailViewController = segue.destinationViewController as! RepoDetailViewController
                if let selectedIndex = tableView.indexPathForCell(cell) {
                    if searchController.active {
                        detailViewController.selectedRepoViewModel = filteredResults[selectedIndex.row]
                    } else {
                        detailViewController.selectedRepoViewModel = repoSearchViewModels[selectedIndex.row]
                    }
                    
                }
                title = ""
            }
        }
    }
    
    /**
     Setup SearchView
     */
    func setupSearchView() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    /**
     Update the NavigationBar Title with the Objects count
     */
    func updateTitle() {
        if let selectedLanguage = filterLanguage {
            if let _ = searchController where searchController.active == true {
                if filteredResults.count > 0 {
                    title = "\(selectedLanguage)(\(filteredResults.count))"
                } else {
                    title = selectedLanguage
                }
            } else {
                if repoSearchViewModels.count > 0 {
                    title = "\(selectedLanguage)(\(repoSearchViewModels.count))"
                } else {
                    title = selectedLanguage
                }
            }
        } else {
            if let _ = searchController where searchController.active == true {
                if filteredResults.count > 0 {
                    title = "All Repositories(\(filteredResults.count))"
                } else {
                    title = "All Repositories"
                }
            } else {
                if repoSearchViewModels.count > 0 {
                    title = "All Repositories(\(repoSearchViewModels.count))"
                } else {
                    title = "All Repositories"
                }
            }
        }
    }
}

//MARK: UITableViewDataSource Methods
extension RepoSearchViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = searchController where searchController.active == true {
            return filteredResults.count
        } else {
            return repoSearchViewModels.count + 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let _ = searchController where searchController.active == true {
            let repoSearchCell = tableView.dequeueReusableCellWithIdentifier("RepoSearchCell", forIndexPath: indexPath) as! RepoSearchTableViewCell
            repoSearchCell.repoSearchViewModel = filteredResults[indexPath.row]
            return repoSearchCell
        } else {
            if indexPath.row == repoSearchViewModels.count {
                let loadingCell = tableView.dequeueReusableCellWithIdentifier("LoadingCell", forIndexPath: indexPath) as! RepoSearchLoadingTableViewCell
                loadingCell.activityIndicatorView.startAnimating()
                return loadingCell
            } else {
                let repoSearchCell = tableView.dequeueReusableCellWithIdentifier("RepoSearchCell", forIndexPath: indexPath) as! RepoSearchTableViewCell
                repoSearchCell.repoSearchViewModel = repoSearchViewModels[indexPath.row]
                return repoSearchCell
            }
        }
    }
}

//MARK: UITableViewDelegate Methods
extension RepoSearchViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.tag == Constants.LoadingTableViewCellTag {
            if let selectedLanguage = filterLanguage {
                presenter.loadRepoWithLanguage(selectedLanguage)
            } else {
                presenter.loadRepoWithLanguage("") /* Load all the repos */
            }
        }
    }
}

//MARK: UISearchResultsUpdating Methods
extension RepoSearchViewController : UISearchResultsUpdating {
    
    /**
     Update the search results after comparing with Repository Name 
     and Language
     
     - parameter searchController: searchController object
     */
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredResults.removeAll(keepCapacity: true)
        let searchText = searchController.searchBar.text!.lowercaseString
        filteredResults.appendContentsOf(repoSearchViewModels.filter {
            $0.repoName.lowercaseString.containsString(searchText) || $0.language.lowercaseString.containsString(searchText)
            })
        if searchController.searchBar.text!.characters.count == 0 {
            filteredResults.appendContentsOf(repoSearchViewModels)
        }
        tableView.reloadData()
        updateTitle()
    }
}

//MARK: RepoSearchView Methods
extension RepoSearchViewController : RepoSearchView {

    /**
     Show the Repository details
     
     - parameter repositoriesViewModel: GitHubRepository ViewModel objects
     */
    func showRepositories(repositoriesViewModel: [RepoSearchViewModel]) {
        repoSearchViewModels.appendContentsOf(repositoriesViewModel)
        updateTitle()
        tableView.reloadData()
    }
    
    /**
     Show the Error Message
     
     - parameter errorString: error message
     */
    func showError(errorString: String) {
        if self.isViewLoaded() && view.window != nil {
            showErrorMessageAlertView("Error", message: errorString, onViewController: self)
        }
    }
}
