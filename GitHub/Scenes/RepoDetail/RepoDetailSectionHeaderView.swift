//
//  RepoDetailSectionHeaderView.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class RepoDetailSectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
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
        }

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.width / 2
        avatarImageView.clipsToBounds = true
    }    
}
