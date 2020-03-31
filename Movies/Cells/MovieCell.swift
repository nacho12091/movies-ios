//
//  MovieCell.swift
//  Movies
//
//  Created by Ignacio Lima on 7/17/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        movieContentView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        movieDescription.textContainerInset = UIEdgeInsets.zero
        movieDescription.textContainer.lineFragmentPadding = 0
        movieDescription.textContainer.lineBreakMode = .byTruncatingTail
        // Configure the view for the selected state
    }
    
    func cellSetup(movie: Movie, useCharacter: Bool) {
        selectionStyle = UITableViewCell.SelectionStyle.none
        backgroundColor = UIColor.cellBackground
        movieTitle.text = movie.title
        movieImage.sd_setImage(with: URL(string: movie.photo))
        if(useCharacter) {
            movieDate.text = movie.desc
            movieDate.alpha = 0.5
            movieDescription.text = ""
        } else {
            movieDate.text = String(movie.releaseDate)
            movieDescription.text = movie.desc
        }
    }
}
