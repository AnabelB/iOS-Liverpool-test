//
//  ProductTableViewCell.swift
//  iOS-Project
//
//  Created by Ana Bernal on 30/08/25.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchIcon.layer.cornerRadius = 12
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.productDisplayName
        searchIcon.loadImage(from: product.lgImage)
        let attributeString = NSMutableAttributedString(string: "$\(product.listPrice)")
        attributeString.addAttribute(.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        priceLabel.attributedText = attributeString
        discountedPriceLabel.text = "$\(product.promoPrice)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
