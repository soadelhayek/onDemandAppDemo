//
//  MovieCell.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation
import UIKit
import SnapKit


class MovieCell: BaseCollectionViewCell {

    var movie: Movie?
    var index: IndexPath?

    lazy var movieThumb: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie 1 Title"
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.natural
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.numberOfLines = 2
        label.sizeToFit()
        label.lineBreakMode = .byTruncatingTail
        label.semanticContentAttribute = Helpers.isRTL() ? .forceRightToLeft : .forceLeftToRight
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.white
        
        layer.masksToBounds = true
        layer.cornerRadius = 8
        
        contentView.addSubview(movieThumb)
        contentView.addSubview(nameLabel)
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieThumb.image = #imageLiteral(resourceName: "Blank")
        nameLabel.text = ""
    }
    
    func setConstraints() {
        
        movieThumb.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.47)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(13)
            make.trailing.equalToSuperview().inset(10)
                make.height.equalTo(32.66)
            make.bottom.equalToSuperview().inset(8)
            }
       
    }
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
