//
//  RepoIssueViewController.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class RepoIssueViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var repoIssueConfigurator = RepoIssueConfigurator()
    var presenter: RepoIssuePresenterInput!
    var issueViewModels: [RepoIssueViewModel] = []
    var repoUrl: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateTitle()
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        
        repoIssueConfigurator.configure(self)
        presenter.loadIssues(repoUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTitle() {
        if issueViewModels.count > 0 {
            title = "Issues(\(issueViewModels.count))"
        } else {
            title = "Issues"
        }
    }
}

extension RepoIssueViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issueViewModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let openIssueCell = tableView.dequeueReusableCellWithIdentifier("OpenIssueCell", forIndexPath: indexPath) as! RepoIssueTableViewCell
        openIssueCell.issueViewModel = issueViewModels[indexPath.row]
        return openIssueCell
    }
}

extension RepoIssueViewController : RepoIssueView {
    
    func showProgress(loading: Bool) {
        if loading {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    func showIssues(viewModels: [RepoIssueViewModel]) {
        issueViewModels.appendContentsOf(viewModels)
        tableView.reloadData()
        updateTitle()
    }
    
    func showErrorMessage(errorMessage: String) {
        if self.isViewLoaded() && view.window != nil {
            showErrorMessageAlertView("Error", message: errorMessage, onViewController: self)
        }
    }
}