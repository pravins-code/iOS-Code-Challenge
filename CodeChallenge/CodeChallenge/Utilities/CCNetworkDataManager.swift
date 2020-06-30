//
//  CCNetworkDataManager.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 27/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import Foundation

// MARK: - Download Data completion handler
typealias DownloadDataComplete = ((Data?, Error?) -> Void)

// MARK: - Data handler method, implement this protocol for local/mock Data and remote data
protocol DataManageable {
    func parseItemData(_ jsonData: Data) -> [DataItem]?
}

class CCNetworkDataManager: DataManageable {
    
    /* reads data from a remote location */
    func readData(with url: String, completion completionBlock: @escaping DownloadDataComplete) -> Void {
        if let requestUrl = URL(string: url) {
            debugPrint(requestUrl)
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else { // check for fundamental networking error
                    debugPrint("error=\(String(describing: error))")
                    completionBlock(nil, error)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {    // check for http errors
                    let responseString = String("response = \(String(describing: response))")
                    debugPrint(responseString)
                    completionBlock(nil, error)
                } else {
                    completionBlock(data, error)
                }
            }
            task.resume()
        } else {
            let error = NSError(domain:"Invalid Url", code: 76, userInfo: nil)
            completionBlock(nil, error)
        }
    }
    
    // MARK: - Parse the json data and return a Codable Model object
    func parseItemData(_ jsonData: Data) -> [DataItem]? {
        var item: [DataItem]? = nil
        do {
            
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve context")
            }
            
            // Parse JSON data
            let managedObjectContext = CCCoreDataStack.context
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            let object = try decoder.decode([DataItem].self, from: jsonData)
            try managedObjectContext.save()
            debugPrint(object)
            item = object
            return item
        } catch let error {
            debugPrint(error)
            return item
        }
    }
}
