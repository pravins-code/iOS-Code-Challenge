//
//  CCImageManager.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 30/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import UIKit
// MARK: completion block to returh the image
typealias HandOverImage = (UIImage?) -> Void

// MARK: ImageManager
class ImageManager {
    
    var completionBlock: HandOverImage?
    
    func downloadImageForUrl(dataInfo: DataItem, completion: @escaping HandOverImage) {
        self.completionBlock = completion
        if let type = dataInfo.type, let path = dataInfo.data, let id = dataInfo.id {
            if type == Constants.image.rawValue {
                if let image = self.loadImageFromDocumentDirectory(fileName: "\(id)") {
                    self.completionBlock!(image)
                } else {
                    CCImageDownloader.shared.downloadImageForUrl(URL(string: path)!) { [unowned self] (image, error) in
                        if (image != nil) {
                            self.completionBlock!(image)
                            self.saveImageInDocumentDirectory(image: image!, fileName: "\(id)")
                        } else {
                            let noImage = UIImage(named: Constants.noImage.rawValue)
                            self.completionBlock!(noImage)
                        }
                    }
                }
            }
        } else {
            let noImage = UIImage(named: Constants.noImage.rawValue)
            self.completionBlock!(noImage)
        }
    }
    
    // MARK: Save Image locally
    private func saveImageInDocumentDirectory(image: UIImage, fileName: String) -> Void {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.pngData() {
            try? imageData.write(to: fileURL, options: .atomic)
        }
    }
    
    // MARK: load Image if available locally
    private func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {}
        return nil
    }
}
