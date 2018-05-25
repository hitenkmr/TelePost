//
//  TopHeadlineCell.swift
//  TelePost
//
//  Created by Hitender kumar on 17/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit
import SDWebImage

class TopHeadlineCell: UITableViewCell {
    
    @IBOutlet weak var headlineImageVw: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCellWith(headline : TopHeadline) {
        self.headlineImageVw?.sd_setImage(with: URL.init(string: headline.urlToImage), placeholderImage: #imageLiteral(resourceName: "headlineImage"), options: SDWebImageOptions.continueInBackground, completed: nil)
        self.sourceLabel.attributedText = "".attributedStringWith(boldPart: "Source : ", boldPartFontSize: 14, normalPart: headline.source.name, normalPartFontSize: 12, boldPartTextColor: BlackColor, normalPartTextColor: WhiteColor)
        
        self.authorLabel.attributedText = "".attributedStringWith(boldPart: "Author : ", boldPartFontSize: 14, normalPart: headline.author, normalPartFontSize: 12, boldPartTextColor: BlackColor, normalPartTextColor: WhiteColor)
        
        let localDateStr = AppDelegate.formattedDateStringWith(dateStr: headline.publishedAt, currentDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", requiredDateFormat: "MM/dd/yyyy HH:mm")
        self.dateLabel.attributedText = "".attributedStringWith(boldPart: "Date : ", boldPartFontSize: 14, normalPart: localDateStr, normalPartFontSize: 12, boldPartTextColor: BlackColor, normalPartTextColor: WhiteColor)
        self.titleLabel.attributedText = "".attributedStringWith(boldPart: "Title : ", boldPartFontSize: 14, normalPart: headline.title, normalPartFontSize: 12, boldPartTextColor: BlackColor, normalPartTextColor: WhiteColor)
        self.descriptionLabel.attributedText = "".attributedStringWith(boldPart: "Description : ", boldPartFontSize: 14, normalPart: headline.desc, normalPartFontSize: 12, boldPartTextColor: BlackColor, normalPartTextColor: WhiteColor)
    }
    
}
