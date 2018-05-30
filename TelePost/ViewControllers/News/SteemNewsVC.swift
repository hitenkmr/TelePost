//
//  SteemNewsVC.swift
//  TelePost
//
//  Created by Hitender kumar on 30/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

enum SteemNewsCategories : String {
    case Trending = "Trending"
    case Hot = "Hot"
    case Promoted = "Promoted"
}

class SteemNewsVC: UIViewController {
    
    @IBOutlet weak var tableview : UITableView!
    var currentNewsArray = [SteemNews]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let newsCategoryBarBtnItem = UIBarButtonItem(title: "Discussion", style: .plain, target: self, action: #selector(self.newsCategoryBarBtnItemAction(item:)))
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont(name: CustomFonts.Montserrat.bold, size: 16)!]
        
        newsCategoryBarBtnItem.setTitleTextAttributes(attrs, for: .normal)
        navigationItem.rightBarButtonItems = [newsCategoryBarBtnItem]
        
        self.navigationItem.title = "Trending"
        self.tableview.tableFooterView = UIView.init()

        self.tableview.estimatedRowHeight = 44
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getSteemNewsWith(category: "get_discussions_by_trending")
    }
    
    //MARK: Helpers
    
    @objc func newsCategoryBarBtnItemAction(item : UIBarButtonItem) {
        let objChooseOptionVC : ChooseOptionVC = ChooseOptionVC.instantiateWithStoryboard(appStoryboard: .SB_News) as! ChooseOptionVC
        objChooseOptionVC.optionsArray = [SteemNewsCategories.Trending.rawValue, SteemNewsCategories.Hot.rawValue, SteemNewsCategories.Promoted.rawValue]
        objChooseOptionVC.delegate = self
        objChooseOptionVC.view.backgroundColor = UIColor.gray
        objChooseOptionVC.modalPresentationStyle = UIModalPresentationStyle.popover
        let popvc = objChooseOptionVC.popoverPresentationController
        popvc?.delegate = self
        popvc?.permittedArrowDirections = UIPopoverArrowDirection.any
        popvc?.barButtonItem = item
        objChooseOptionVC.preferredContentSize = CGSize.init(width: 200, height: 200)
        self.present(objChooseOptionVC, animated: true, completion: nil)
    }
    
    //MARK: Web Services
    
    func getSteemNewsWith(category : String) {
        self.startAnimator()
        APIMaster.getSteemitNewsWith(category: category, completion: { (anyObject, httpResponse) in
            DispatchQueue.main.async(execute: {
                self.stopAnimator()
            })
            DispatchQueue.global(qos: .background).async(execute: {
                self.currentNewsArray.removeAll()
                if let jsonArray = anyObject as? [[String : Any]] {
                    jsonArray.forEach({ (object) in
                        let steemNewsModel = SteemNews.init(info: object)
                        self.currentNewsArray.append(steemNewsModel)
                    })
                } else {
                    var errorMsg = Messages.InternalServerError
                    if let infoArr = (anyObject as? [Any]), let errorInfo = infoArr[1] as? [String : Any], let message =  errorInfo["message"] as? String {
                        errorMsg =  message
                    }
                    self.showAlertWith(title: "Error", message: errorMsg)
                }
                DispatchQueue.main.async(execute: {
                    self.tableview.reloadData()
                })
            })
        }) { (error) in
            DispatchQueue.main.async(execute: {
                self.stopAnimator()
                self.showAlertWith(title: "Error", message: error.localizedDescription)
            })
        }
    }
}

extension SteemNewsVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.currentNewsArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SteemNewsTableCell = tableView.dequeueReusableCell(withIdentifier: "SteemNewsTableCell", for: indexPath) as! SteemNewsTableCell
        cell.delegate = self
        cell.upvoteBtn.tag = indexPath.section
        cell.selectionStyle = .none
        let steemNews = self.currentNewsArray[indexPath.section]
        cell.updateCellData(steemNews: steemNews)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
}

extension SteemNewsVC : ChooseOptionVCDelegate {
    
    //MARK: ChooseOptionVCDelegate
    
    func didSelectOption(_ option: String, observingObject: Any?) {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
        self.navigationItem.title = option
        var cat = "get_discussions_by_trending"
        if option == SteemNewsCategories.Trending.rawValue {
            cat = "get_discussions_by_trending"
        } else if option == SteemNewsCategories.Hot.rawValue {
            cat = "get_discussions_by_hot"
        } else if option == SteemNewsCategories.Promoted.rawValue {
            cat = "get_discussions_by_promoted"
        }
        self.getSteemNewsWith(category: cat)
    }
}

extension SteemNewsVC : UIPopoverPresentationControllerDelegate {
    
    //MARK: UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
}

extension SteemNewsVC : SteemNewsTableCellDeleagate {
    
    //MARK: SteemNewsTableCellDeleagate
    
    func didClickUpvoteBtn(_ sender: UIButton) {
        self.startAnimator()
        let steemNews = self.currentNewsArray[sender.tag]
        let author = steemNews.author
        let permlink = steemNews.permlink
        STClient.downVote(voter: DataManager.sharedInstance.getUserName(), author: author, permlink: permlink, weight: 10000, to:nil) { (response, error) in
            DispatchQueue.main.async(execute: {
                self.stopAnimator()
            })
            if error != nil {
                self.currentNewsArray[sender.tag].have_i_voted = true
                DispatchQueue.main.async(execute: {
                    self.tableview.reloadData()
                })
            }
        }
    }
}

