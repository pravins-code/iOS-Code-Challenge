//
//  CellViewModel.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 28/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import UIKit

class CellViewModel: UIView {
    
    // MARK: - Properties Initializer
    lazy var dataLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.textColor     = .black
        return lbl
    }()
    //Creates Image view
    lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        imgView.contentMode     = .scaleAspectFit
        imgView.clipsToBounds   = true
        imgView.backgroundColor = .clear
        imgView.isHidden        = false
        imgView.image = UIImage(named: "default")
        return imgView
    }()
    
    var dataInfo : DataItem?
    
    func configureCell(dataInfo: DataItem) {
        self.dataInfo = dataInfo
        if(self.dataInfo?.type == "image") {
            self.downloadImageForUrl()
            self.dataLabel.isHidden = true
            self.imageView.isHidden = false
        } else {
            self.imageView.isHidden = true
            self.dataLabel.isHidden = false
            self.dataLabel.text = self.dataInfo?.data
        }
    }
    
    func resetUIViewData() {
        self.imageView.image = UIImage(named: "default")
        self.dataLabel.text = self.dataInfo?.data
    }
    
    private func downloadImageForUrl() {
        if let type = self.dataInfo?.type, let path = self.dataInfo?.data, let id = self.dataInfo?.id {
            if type == "image" {
                if let image = self.loadImageFromDocumentDirectory(fileName: "\(id)") {
                    self.imageView.image = image
                } else {
                    CCImageDownloader.shared.downloadImageForUrl(URL(string: path)!) {[weak self] (image, error) in
                        if (image != nil) {
                            DispatchQueue.main.async {
                                self?.imageView.image = image
                                self?.saveImageInDocumentDirectory(image: image!, fileName: "\(id)")
                            }
                        } else {
                            let noImage = UIImage(named: "noImage")
                            DispatchQueue.main.async {
                                self?.imageView.image = noImage
                            }
                        }
                    }
                }
            } else {
                let noImage = UIImage(named: "noImage")
                DispatchQueue.main.async {
                    self.imageView.image = noImage
                }
            }
        }
    }
        
        func saveImageInDocumentDirectory(image: UIImage, fileName: String) -> Void {
            let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
            let fileURL = documentsUrl.appendingPathComponent(fileName)
            if let imageData = image.pngData() {
                try? imageData.write(to: fileURL, options: .atomic)
            }
        }
        
        func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
            let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
            let fileURL = documentsUrl.appendingPathComponent(fileName)
            do {
                let imageData = try Data(contentsOf: fileURL)
                return UIImage(data: imageData)
            } catch {}
            return nil
        }
}
