//
//  ImageCell.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(image: String?) {
        guard let imgStr = image else {
            imageView.image = nil
            return
        }
        ImageLoader.shared.loadImage(from: imgStr, completion: { result in
            DispatchQueue.main.async {
                self.imageView.image = result
            }
        })
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }

}
