//
//  SteemNewsTableCell.swift
//  TelePost
//
//  Created by Hitender kumar on 30/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit
import SDWebImage

class SteemNewsTableCell: UITableViewCell {
    
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var postCommentsCountLabel: UILabel!
    @IBOutlet var postUpvotesCountLabel: UILabel!
    @IBOutlet var createdAtLabel: UILabel!

    //MARK: LIFE CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.authorNameLabel.addShadowWith(shadowOffset: CGSize(width: 5, height: 5), shadowOpacity: 5.0, shadowRadius: 12.0)
//        self.postTitle.addShadowWith(shadowOffset: CGSize(width: 5, height: 5), shadowOpacity: 5.0, shadowRadius: 12.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: HELPERS
    
    func updateCellData(steemNews : SteemNews) {
        self.postTitle.text = steemNews.title
        //self.postUpvotesCountLabel.text = "\(steemNews.net_votes)"
        //self.postCommentsCountLabel.text = "\(steemNews.childrens)"
        authorNameLabel.text = steemNews.author
        self.postImageView.sd_setImage(with: steemNews.image_url, placeholderImage: #imageLiteral(resourceName: "news_placeholder"), options: .retryFailed, completed: nil)
        
        let createdAt = AppDelegate.formattedDateStringWith(dateStr: steemNews.created, currentDateFormat: "yyyy-MM-dd'T'HH:mm:ss", requiredDateFormat: "EEEE, MMM d, yyyy")
        createdAtLabel.text = createdAt
    }
}
