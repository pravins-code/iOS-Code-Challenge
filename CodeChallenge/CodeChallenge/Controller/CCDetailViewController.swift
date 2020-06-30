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
    //Creates horizontal stack view
    lazy private var horizontalStackView: UIStackView = {
        let hsv = UIStackView(arrangedSubviews: [self.imageView, self.dataLabel])
        hsv.distribution    = .fill
        hsv.axis            = .horizontal
        hsv.alignment       = .center
        hsv.spacing         = 5
        hsv.backgroundColor = .white
        self.view.addSubview(hsv)
        return hsv
    }()
    
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
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300))
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

        // Horizontal Stack view constraint
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
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
                self.imageManger.downloadImageForUrl(dataInfo: dataInfo, completion: {(image) in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                })
                self.dataLabel.isHidden = true
                self.imageView.isHidden = false
            } else {
                self.imageView.isHidden = true
                self.dataLabel.isHidden = false
                self.dataLabel.text = dataInfo.data
            }
        }
    }
}
