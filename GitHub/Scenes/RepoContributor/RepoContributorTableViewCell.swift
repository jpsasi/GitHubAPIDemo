//
//  RepoContributorTableViewCell.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class RepoContributorTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var avatarImageDownloaderTask: NSURLSessionDataTask!
    let emptyImage: UIImage = UIImage(named: "EmptyProfileImage")!

    var contributorModel: GitHubUser? {
        didSet {
        if let contributorModel = contributorModel {
            
            avatarImageView.image = emptyImage
            if avatarImageDownloaderTask != nil {
                avatarImageDownloaderTask.cancel()
            }
            
            avatarImageDownloaderTask = ImageLoader.sharedInstance.loadImageInBackgroundWithUrl(contributorModel.avatarUrl) { image in
                self.avatarImageView.image = image
            }
            
            nameLabel.text = contributorModel.login
        }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.width / 2
        avatarImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
