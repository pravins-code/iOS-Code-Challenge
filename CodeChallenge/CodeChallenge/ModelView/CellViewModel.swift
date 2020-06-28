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
    lazy var idLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 19)
        lbl.textColor       = .black
        lbl.numberOfLines   = 1
        lbl.textAlignment   = .left
        return lbl
    }()
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
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
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
        self.downloadImageForUrl()
        self.idLabel.text = self.dataInfo?.id
        self.dataLabel.text = self.dataInfo?.data
    }
    
    func resetUIViewData() {
        self.imageView.image = UIImage(named: "default")
        self.idLabel.text = self.dataInfo?.id
        self.dataLabel.text = self.dataInfo?.data
    }
    
    private func downloadImageForUrl() {
        if let type = self.dataInfo?.type, let path = self.dataInfo?.data {
            if type == "image" {
            CCImageDownloader.shared.downloadImageForUrl(URL(string: path)!) {[weak self] (image, error) in
                if (image != nil) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
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
