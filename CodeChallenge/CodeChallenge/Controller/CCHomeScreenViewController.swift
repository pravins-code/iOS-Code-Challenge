//
//  CCHomeScreenViewController.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 27/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import UIKit

class CCHomeScreenViewController: UITableViewController {
    
    // Instance variables
    private var mainViewModelObj: CCMainViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.register(CCDataItemTableViewCell.self)

        mainViewModelObj = CCMainViewModel()
        if let mainViewModel = mainViewModelObj {
            mainViewModel.readDataCompleted = { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                if error != nil {
                    // Error reading data
                    self.showAlert(error! as NSError, title: "Error reading data", message: "", buttonTitle: "Ok")
                }
            }
            mainViewModel.loadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mainViewModelObj?.dataItemList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: CCDataItemTableViewCell.self, for: indexPath)

        if let dataInfo = mainViewModelObj?.dataItemList![indexPath.row] {
            cell.dataValue = dataInfo
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = CCDetailViewController()
        if let dataInfo = mainViewModelObj?.dataItemList![indexPath.row] {
            detailView.dataValue = dataInfo
        }
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    // MARK: - AlertView
    
    func showAlert(_ error: NSError, title: String, message: String, buttonTitle: String) {
        var errorDetail: String? = nil
        let errorExtraInfo =  error.userInfo["info"]
        if (errorExtraInfo is String) {
            errorDetail = errorExtraInfo as? String
        } else {
            errorDetail = error.description
        }
        
        let uiAlert = UIAlertController(title: title, message: "\(message) \(errorDetail ?? "").", preferredStyle: .alert)
        uiAlert.addAction(UIAlertAction(title: NSLocalizedString(buttonTitle, comment: "Default action"), style: .default, handler: { _ in
            debugPrint("Alert button tap")
        }))
        
        DispatchQueue.main.async {
            self.present(uiAlert, animated: true, completion: nil)
        }
    }
    
}
