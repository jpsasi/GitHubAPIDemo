//
//  RepoDetailViewController.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class RepoDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var repoDetailConfigurator = RepoDetailConfigurator.sharedInstance
    var presenter: RepoDetailPresenterInput!
    
    var selectedRepoViewModel: RepoSearchViewModel! {
        didSet {
            updateTitle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repoDetailConfigurator.configure(self)

        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTitle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "OpenIssueSegue" {
                let openIssueViewController = segue.destinationViewController as! RepoIssueViewController
                title = ""
                openIssueViewController.repoUrl = selectedRepoViewModel.repoUrl
            } else if identifier == "ContibutorsSegue" {
                let contributorsViewController = segue.destinationViewController as! RepoContributorViewController
                contributorsViewController.contributorsUrl = selectedRepoViewModel.contributorUrl
            }
        }
    }
    
    func updateTitle() {
        title = selectedRepoViewModel.repoName
    }
}

extension RepoDetailViewController : UITableViewDataSource {
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let summaryCell = tableView.dequeueReusableCellWithIdentifier("RepoSummaryCell", forIndexPath: indexPath) as! RepoSummaryTableViewCell
            summaryCell.repoViewModel = selectedRepoViewModel
            return summaryCell
        } else {
            if indexPath.row == 0 {
                let noOpenIssueCell = tableView.dequeueReusableCellWithIdentifier("OpenIssueCell", forIndexPath: indexPath)
                return noOpenIssueCell
            } else {
                let contributorsCell = tableView.dequeueReusableCellWithIdentifier("ContributorsCell", forIndexPath: indexPath)
                return contributorsCell
            }
        }
    }
}


extension RepoDetailViewController : RepoDetailView {
        
    func showErrorMessage(errorMessage: String) {
        if self.isViewLoaded() && view.window != nil {
            showErrorMessageAlertView("Error", message: errorMessage, onViewController: self)
        }
    }
}