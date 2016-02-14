//
//  RepoSearchTableViewCell.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class RepoSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    let emptyImage: UIImage = UIImage(named: "EmptyProfileImage")!
    var avatarImageDownloaderTask: NSURLSessionDataTask!

    var repoSearchViewModel: RepoSearchViewModel? {
        didSet {
        if let repoSearchViewModel = repoSearchViewModel {
            
            repoNameLabel.text = repoSearchViewModel.repoName
            repoDescriptionLabel.text = repoSearchViewModel.repoDescription
            languageLabel.text = repoSearchViewModel.language
            
            avatarImageView.image = emptyImage
            if avatarImageDownloaderTask != nil {
                avatarImageDownloaderTask.cancel()
            }
            
            avatarImageDownloaderTask = ImageLoader.sharedInstance.loadImageInBackgroundWithUrl(repoSearchViewModel.avatarUrl) { image in
                self.avatarImageView.image = image
            }
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
