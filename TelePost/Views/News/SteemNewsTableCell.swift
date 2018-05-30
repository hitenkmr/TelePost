//
//  SteemNewsTableCell.swift
//  TelePost
//
//  Created by Hitender kumar on 30/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit
import SDWebImage

protocol SteemNewsTableCellDeleagate {
    func didClickUpvoteBtn(_ sender : UIButton)
}

class SteemNewsTableCell: UITableViewCell {
    
    @IBOutlet weak var upvoteBtn : UIButton!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var postCommentsCountLabel: UILabel!
    @IBOutlet var postPayoutLabel: UILabel!
    @IBOutlet var createdAtLabel: UILabel!

    var delegate : SteemNewsTableCellDeleagate?
    
    //MARK: LIFE CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.authorNameLabel.addShadowWith(shadowOffset: CGSize(width: 5, height: 5), shadowOpacity: 5.0, shadowRadius: 12.0)
//        self.postTitle.addShadowWith(shadowOffset: CGSize(width: 5, height: 5), shadowOpacity: 5.0, shadowRadius: 12.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Interface Builder Actions
    
    @IBAction func upvoteBtnAction(_ sender : UIButton) {
        if self.delegate != nil {
            self.delegate?.didClickUpvoteBtn(sender)
         }
    }
    
    //MARK: HELPERS
    
    func updateCellData(steemNews : SteemNews) {
        self.postTitle.text = steemNews.title
        self.postPayoutLabel.text = steemNews.payout
        self.postCommentsCountLabel.text = "\(steemNews.childrens)"
        authorNameLabel.text = "By : " + steemNews.author
        self.postImageView.sd_setImage(with: steemNews.image_url, placeholderImage: #imageLiteral(resourceName: "no_image"), options: .retryFailed, completed: nil)
        
        let createdAt = AppDelegate.formattedDateStringWith(dateStr: steemNews.created, currentDateFormat: "yyyy-MM-dd'T'HH:mm:ss", requiredDateFormat: "EEEE, MMM d, yyyy")
        createdAtLabel.text = createdAt
        self.upvoteBtn.imageView?.image = #imageLiteral(resourceName: "upvote").withRenderingMode(.alwaysTemplate)
        self.upvoteBtn.tintColor = WhiteColor
        if steemNews.have_i_voted {
            self.upvoteBtn.tintColor = RedColor
        }
        self.upvoteBtn.isUserInteractionEnabled = !steemNews.have_i_voted
    }
    
}
