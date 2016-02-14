//
//  RepoSummaryTableViewCell.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class RepoSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var watchesLabel: UILabel!
    
    var avatarImageDownloaderTask: NSURLSessionDataTask!
    let emptyImage: UIImage = UIImage(named: "EmptyProfileImage")!
    
    var repoViewModel: RepoSearchViewModel? {
        didSet {
        if let repoViewModel = repoViewModel {
            avatarImageView.image = emptyImage
            if avatarImageDownloaderTask != nil {
                avatarImageDownloaderTask.cancel()
            }
            
            avatarImageDownloaderTask = ImageLoader.sharedInstance.loadImageInBackgroundWithUrl(repoViewModel.avatarUrl) { image in
                self.avatarImageView.image = image
            }
            
            repoDescriptionLabel.text = repoViewModel.repoDescription
            watchesLabel.text = "\(repoViewModel.watchers)"
            starsLabel.text = "\(repoViewModel.stars)"
            forksLabel.text = "\(repoViewModel.forks)"
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
