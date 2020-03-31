//
//  KnownForCollectionViewCell.swift
//  Movies
//
//  Created by Ignacio Lima on 8/22/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class KnownForCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
    }
    
    func cellSetup(movie: Movie) {
        movieTitle.text = movie.title
        movieImage.sd_setImage(with: URL(string: movie.photo))
        backgroundColor = UIColor.white
    }
}
