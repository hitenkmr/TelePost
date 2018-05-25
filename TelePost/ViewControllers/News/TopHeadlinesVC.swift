//
//  TopHeadlinesVC.swift
//  TelePost
//
//  Created by Hitender kumar on 17/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

class TopHeadlinesVC: UIViewController {

    @IBOutlet weak var countryTopHeadlinesCollectionView : UICollectionView!
 
    var countries = [CountryProtocol]()
    var currentHeadlines = [TopHeadline]()
    var currentIndexPath = IndexPath.init(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Top Headlines"
        let currentLocale = NSLocale.current
        if let regionCode = currentLocale.regionCode {
            self.gettopHeadlinesWith(countryCode: regionCode.lowercased())
        }
        //let countriesIsoCodes = NSLocale.isoCountryCodes
        //currentLocale.localizedString(forRegionCode: countries.first!)
    }
    
    //MARK: Helpers
    
    //MARK: WEB SERVICES
    
    func gettopHeadlinesWith(countryCode: String) {
        self.startAnimator()
        APIMaster.getTopHeadlinesWith(countryCode: countryCode, completion: { (json, httpResponse) in
            DispatchQueue.main.async(execute: {
                self.stopAnimator()
            })
            guard let json = json else {
                self.showAlertWith(title: "Error", message: Messages.UnableToLoadfeeds)
                return
            }
            if httpResponse.statusCode == 200 {
                if let articles = json["articles"] as? [[String : Any]] {
                    var headlines = [TopHeadline]()
                    articles.forEach({ (article) in
                        let articleModel = TopHeadline.init(info: article)
                        headlines.append(articleModel)
                    })
                    self.currentHeadlines = headlines
                }
                DispatchQueue.main.async(execute: {
                    self.countryTopHeadlinesCollectionView.reloadData()
                })
            } else {
                var errorMsg = Messages.InternalServerError
                if let message = json["message"] as? String {
                    errorMsg = message
                }
                self.showAlertWith(title: "Error", message:errorMsg)
            }
        }) { (error) in
            DispatchQueue.main.async(execute: {
                self.stopAnimator()
                self.showAlertWith(title: "Error", message:error.localizedDescription)
            })
        }
    }
}

extension TopHeadlinesVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell : CountryTopHeadlinesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryTopHeadlinesCollectionViewCell", for: indexPath) as! CountryTopHeadlinesCollectionViewCell
        cell.delegate = self
        cell.headLines = self.currentHeadlines
        cell.topHeadlinesTableView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return collectionView.frame.size
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}

extension TopHeadlinesVC : CountryTopHeadlinesCollectionViewCellDelegate {
    
    //MARK: CountryTopHeadlinesCollectionViewCellDelegate
    
    func didClickHeadlineWith(indexPath: IndexPath) {
        let objTelePostWebViewVC : TelePostWebViewVC = TelePostWebViewVC.instantiateWithStoryboard(appStoryboard: .SB_News) as! TelePostWebViewVC
         let headline = self.currentHeadlines[indexPath.row]
         objTelePostWebViewVC.titleText = headline.title
         objTelePostWebViewVC.url = URL.init(string: headline.url)
         self.present(objTelePostWebViewVC, animated: true, completion: nil)
    }
}

