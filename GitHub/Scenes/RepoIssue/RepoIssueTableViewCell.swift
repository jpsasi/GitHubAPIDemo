//
//  RepoIssueTableViewCell.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class RepoIssueTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var issueIdLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    var issueViewModel: RepoIssueViewModel? {
        didSet {
        if let issueViewModel = issueViewModel {
            titleLabel.text = issueViewModel.title
            stateLabel.text = issueViewModel.state
            issueIdLabel.text = "#\(issueViewModel.issueNumber)"
            createdDateLabel.text = "opened \(issueViewModel.createdDateString) "
        }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
