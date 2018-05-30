//
//  SteemNewsVC.swift
//  TelePost
//
//  Created by Hitender kumar on 30/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

class SteemNewsVC: UIViewController {
    
    @IBOutlet weak var tableview : UITableView!
    
    var currentNewsArray = [SteemNews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Trending"
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
    
    //MARK: Web Services
    
    func getSteemNewsWith(category : String) {
        self.startAnimator()
        APIMaster.getSteemitNewsWith(category: category, completion: { (anyObject, httpResponse) in
            DispatchQueue.main.async(execute: {
                self.stopAnimator()
            })
            DispatchQueue.global(qos: .background).async(execute: {
                if let jsonArray = anyObject as? [[String : Any]] {
                    jsonArray.forEach({ (object) in
                        let steemNewsModel = SteemNews.init(info: object)
                        self.currentNewsArray.append(steemNewsModel)
                    })
                    DispatchQueue.main.async(execute: {
                        self.tableview.reloadData()
                    })
                }
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

