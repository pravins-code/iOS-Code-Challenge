//
//  ViewModel.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 27/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import Foundation

class MainViewModel {
    
    // MARK: - instance variables declaration
    private let url = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    private let networkDataManager = CCNetworkDataManager()
    public var readDataCompleted: ((Bool, Error?) -> Void)?
    internal var dataItemList: [DataItem]?
    
    init() {
    }
    
    // MARK: - load Data method impementation
    func loadData() {
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
    }
}
