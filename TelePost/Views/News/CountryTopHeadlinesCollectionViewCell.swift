//
//  CountryTopHeadlinesCollectionViewCell.swift
//  TelePost
//
//  Created by Hitender kumar on 17/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

protocol CountryTopHeadlinesCollectionViewCellDelegate {
    func didClickHeadlineWith(indexPath : IndexPath)
}

class CountryTopHeadlinesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topHeadlinesTableView : UITableView!
    var headLines = [TopHeadline]()

    var delegate : CountryTopHeadlinesCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.topHeadlinesTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.topHeadlinesTableView.estimatedRowHeight = 44
        self.topHeadlinesTableView.rowHeight = UITableViewAutomaticDimension
        self.topHeadlinesTableView.reloadData()
    }
    
}

extension CountryTopHeadlinesCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TopHeadlineCell = tableView.dequeueReusableCell(withIdentifier: "TopHeadlineCell", for: indexPath) as! TopHeadlineCell
        let headline = self.headLines[indexPath.row]
        cell.configureCellWith(headline: headline)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.didClickHeadlineWith(indexPath: indexPath)
        }
    }
}
