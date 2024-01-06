//
//  HomeCollectionViewCell.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//

import UIKit
import SDWebImage
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    private let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    func setupView(product: ProductModel){
        contentView.addSubview(cellImage)
        cellImage.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        self.startSkeleton()
        cellImage.sd_setImage(with: URL(string: product.image), completed: { (image, error, cacheType, imageURL) in
            
            if let error = error {
                self.setupBroken()
            }
            
            self.stopSkeleton()
        })
    }
    
    private func setupBroken() {
        cellImage.image = UIImage(named: "img-broken-image")
        
        contentView.addSubview(cellImage)
        cellImage.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
    
}

