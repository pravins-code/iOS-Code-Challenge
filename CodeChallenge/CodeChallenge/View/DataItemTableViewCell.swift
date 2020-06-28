//
//  DataItemTableViewCell.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 28/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import UIKit

class DataItemTableViewCell: UITableViewCell {

    // MARK: - Properties Initializer
    //Creates vertical stack view
    lazy private var verticalStackView: UIStackView = {
        let vsv = UIStackView(arrangedSubviews: [self.imageCellViewModel.idLabel, self.imageCellViewModel.dataLabel])
        vsv.distribution  = .fill
        vsv.axis          = .vertical
        vsv.alignment     = .leading
        vsv.spacing       = 2
        return vsv
    }()
    
    //Creates horizontal stack view
    lazy private var horizontalStackView: UIStackView = {
        let hsv = UIStackView(arrangedSubviews: [self.imageCellViewModel.imageView, verticalStackView])
        hsv.distribution    = .fill
        hsv.axis            = .horizontal
        hsv.alignment       = .center
        hsv.spacing         = 5
        addSubview(hsv)
        return hsv
    }()
    
    // view model
    var imageCellViewModel = CellViewModel()
    
    var dataValue : DataItem? {
        didSet {
            if let dataInfo = self.dataValue {
                self.imageCellViewModel.configureCell(dataInfo: dataInfo)
            }
        }
    }
    
    // MARK: - Life cycle methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        self.selectionStyle = .none
        self.setupLayoutConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageCellViewModel.resetUIViewData()
    }
    
    // MARK: - setup layout contraints
    private func setupLayoutConstraints() {
        //setting Description label content hugging

        // Horizontal Stack view constraint
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ])
        
        let aspectConstraint = NSLayoutConstraint(item: self.imageCellViewModel.imageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.imageCellViewModel.imageView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 1)
        self.imageCellViewModel.imageView.addConstraint(aspectConstraint)
        self.imageCellViewModel.imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.imageCellViewModel.imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        layoutSubviews()
        layoutIfNeeded()
    }
}
