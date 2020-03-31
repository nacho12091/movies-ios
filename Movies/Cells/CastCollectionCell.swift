//
//  CastCollectionCell.swift
//  Movies
//
//  Created by Ignacio Lima on 8/22/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class CastCollectionCell: UICollectionViewCell {
    
    private struct keys {
        static let defaultFemale = "defaultFemale"
        static let defaultMale = "defaultMale"
    }
    
    @IBOutlet weak var castName: UILabel!
    @IBOutlet weak var castImage: UIImageView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
    }
    
    func cellSetup(person: CastAndCrew) {
        
        castName.text = person.personName
        castImage.sd_setImage(with: URL(string: person.personImageURL))
        backgroundColor = UIColor.white
        backgroundColor = UIColor.cellBackground
        if(person.personImageURL == "") {
            if(person.personGender == 1) {
                let defaultImage: UIImage = UIImage(named: keys.defaultFemale)!
                self.castImage.image = defaultImage
            } else {
                let defaultImage: UIImage = UIImage(named: keys.defaultMale)!
                self.castImage.image = defaultImage
            }
        } else {
            self.castImage.sd_setImage(with: URL(string: person.personImageURL))
        }
    }
    
}
