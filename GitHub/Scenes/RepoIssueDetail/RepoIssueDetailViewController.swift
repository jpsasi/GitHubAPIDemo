//
//  RepoIssueDetailViewController.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class RepoIssueDetailViewController: UIViewController {

    var issueDetailConfigurator = RepoIssueDetailConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        issueDetailConfigurator.configure(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RepoIssueDetailViewController : RepoIssueDetailView {
    
}