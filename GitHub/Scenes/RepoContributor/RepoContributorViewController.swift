//
//  RepoContributorViewController.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class RepoContributorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var presenter: RepoContributorPresenterInput!
    var contributorConfigurator = RepoContributorConfigurator()
    var contributorsUrl: String!
    var contributors: [GitHubUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        
        updateTitle()
        contributorConfigurator.configure(self)
        presenter.loadContributors(contributorsUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTitle() {
        if contributors.count > 0 {
            title = "Contributors(\(contributors.count))"
        } else {
            title = "Contributors"
        }
    }
}

extension RepoContributorViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributors.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let contributorCell = tableView.dequeueReusableCellWithIdentifier("ContributorCell", forIndexPath: indexPath) as! RepoContributorTableViewCell
        contributorCell.contributorModel = contributors[indexPath.row]
        return contributorCell
    }
}

extension RepoContributorViewController : RepoContributorView {
    
    func showProgress(loading: Bool) {
        if loading {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    func showContributors(contributors: [GitHubUser]) {
        self.contributors.appendContentsOf(contributors)
        tableView.reloadData()
        updateTitle()
    }
    
    func showErrorMessage(message: String) {
        if view.window != nil && isViewLoaded() {
            showErrorMessageAlertView("Error", message: message, onViewController: self)
        }
    }
}