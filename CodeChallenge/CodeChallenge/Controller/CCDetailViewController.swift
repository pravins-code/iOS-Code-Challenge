//
//  CCDetailViewController.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 30/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import UIKit

class CCDetailViewController: UIViewController {

    // MARK: - Properties Initializer
    lazy var dataLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300))
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.textColor     = .black
        lbl.backgroundColor = .white
        return lbl
    }()
    
    //Creates Image view
    lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        imgView.contentMode     = .scaleAspectFit
        imgView.clipsToBounds   = true
        imgView.isHidden        = false
        imgView.image = UIImage(named: Constants.defaultImage.rawValue)
        return imgView
    }()
    
    var dataValue : DataItem?
    let imageManger = ImageManager()

    override func loadView() {
        super.loadView()

        let aspectConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.imageView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 1)
        self.imageView.addConstraint(aspectConstraint)
        self.imageView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        if let dataInfo = self.dataValue {
            if(dataInfo.type == Constants.image.rawValue) {
                self.view.addSubview(self.imageView)
                self.imageManger.downloadImageForUrl(dataInfo: dataInfo, completion: {(image) in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                })
            } else {
                self.view.addSubview(self.dataLabel)
                self.dataLabel.text = dataInfo.data
            }
        }
    }
}
