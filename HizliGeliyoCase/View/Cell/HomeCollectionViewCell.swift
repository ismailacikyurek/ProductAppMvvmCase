//
//  HomeCollectionViewCell.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
  
    func configure(content : ProductsModel) {
       productName.text = content.title
        productPrice.text = "\(content.price!) TL"
        guard let image = content.image else {return}
        productImage.kf.setImage(with:URL(string: image))
    }
}

extension HomeCollectionViewCell {
    func roundCornerss(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
