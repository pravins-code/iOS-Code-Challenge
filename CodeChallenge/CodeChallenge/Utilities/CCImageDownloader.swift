//
//  CCImageDownloader.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 28/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import Foundation

import UIKit

typealias ImageDownloadCompletionHandler = (UIImage?, DownloadError?) -> Void

final class CCImageDownloader {
    // variables/methods for Singleton instance
    static let shared = CCImageDownloader()
    private init () {}
    
    // MARK: - Handles image download url session configuration
    let imageDownloaderSession: URLSession = {
        let  configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest  = 60.0
        configuration.timeoutIntervalForResource = 60.0
        configuration.urlCache = nil
        configuration.httpCookieStorage          = nil
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    // MARK: - downloads image from server
    func downloadImageForUrl(_ url: URL, withCompletionHandler completionHandler:@escaping ImageDownloadCompletionHandler) -> Swift.Void {
        self.imageDownloaderSession.dataTask(with: url) { (data, urlResponse, error) in
            print(url)
            if let error = error {
                completionHandler(nil, DownloadError.message(message: error.localizedDescription))
            }
            guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
                completionHandler(nil, DownloadError.unknownError)
                return
            }
            guard let data = data, httpUrlResponse.statusCode == 200 else {
                let message = HTTPURLResponse.localizedString(forStatusCode: httpUrlResponse.statusCode)
                completionHandler(nil, DownloadError.requestFailed(statusCode: httpUrlResponse.statusCode, message: message))
                return
            }
            let image = UIImage(data: data)
                completionHandler(image, nil)
            }.resume()
    }
}

// MARK: - Error handling for image downloading cases
enum DownloadError: Error {
    case invalidURLPath
    case message(message: String)
    case unknownError
    case requestFailed(statusCode: Int, message: String)
}
