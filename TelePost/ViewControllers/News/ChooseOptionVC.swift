//
//  ChooseOptionVC.swift
//  HowNowSchool
//
//  Created by Hitender kumar on 05/04/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

protocol ChooseOptionVCDelegate {
    func didSelectOption(_ option : String, observingObject : Any?)
}

class ChooseOptionVC: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var optionsTableView : UITableView!
    var optionsArray = [String]()
    
    var delegate : ChooseOptionVCDelegate?
    var observingObject : Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        optionsTableView.tableFooterView = UIView.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Interface Builder Actions
    
    @IBAction func cancelBtnAction(_ sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ChooseOptionVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        cell.textLabel?.text = self.optionsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.didSelectOption(self.optionsArray[indexPath.row], observingObject: self.observingObject)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
