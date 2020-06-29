//
//  ViewModel.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 27/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import Foundation
import Reachability

class MainViewModel {
    
    // MARK: - instance variables declaration
    private let url = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    private let networkDataManager = CCNetworkDataManager()
    public var readDataCompleted: ((Bool, Error?) -> Void)?
    internal var dataItemList: [DataItem]?
    
    private var reachability: Reachability?
    
    init() {
        
    }
    
    // MARK: - load Data method impementation
    func loadData() {
        do {
            try reachability = Reachability()
            reachability!.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
            }
            reachability!.whenUnreachable = { _ in
                print("Not reachable")
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
            
            try reachability!.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
        let networkAvailable = reachability!.connection != .unavailable
        
        if networkAvailable {
            networkDataManager.readData(with: url, completion: { [unowned self] (data, error) in
                if (data != nil) {
                    if let dataList = self.networkDataManager.parseItemData(data!) {
                        self.dataItemList = dataList
                    }
                }
                if let loadCompletionBlock = self.readDataCompleted {
                    loadCompletionBlock(data != nil, error)
                }
            })
        } else {
            let _ = fetchData()
        }
    }
    
    func fetchData() -> Bool  {
        let fetchRequest = DataItem.fetchDataRequest()
        let managedContext = CCCoreDataStack.context
        
        let _ : NSError! = nil
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            dataItemList = fetchedResults
            //            print(dataItemList!)
            return (dataItemList!.count > 0)
        } catch let error {
            print("Fetching error : \(error)")
            return false
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        case .unavailable:
            print("Unavailable")
        }
    }
    
    
    deinit {
        
    }
    
    func sortData() {
        
    }
}
