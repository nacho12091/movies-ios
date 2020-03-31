//
//  CastAndCrewCell.swift
//  Movies
//
//  Created by Ignacio Lima on 8/8/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class CastAndCrewCell: UITableViewCell {
    
    private struct keys {
        static let defaultFemale = "defaultFemale"
        static let defaultMale = "defaultMale"
    }
    
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personDescription: UITextView!
    @IBOutlet weak var castAndCrewContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        personDescription.textContainerInset = UIEdgeInsets.zero
        personDescription.textContainer.lineFragmentPadding = 0
        castAndCrewContentView.layer.cornerRadius = 4
    }
    
    func cellSetup(person: CastAndCrew) {
        selectionStyle = UITableViewCell.SelectionStyle.none
        backgroundColor = UIColor.cellBackground
        self.personName.text = person.personName
        self.personDescription.text = person.personDescription
        if(person.personImageURL == "") {
            if(person.personGender == 1) {
                let defaultImage: UIImage = UIImage(named: keys.defaultFemale)!
                self.personImage.image = defaultImage
            } else {
                let defaultImage: UIImage = UIImage(named: keys.defaultMale)!
                self.personImage.image = defaultImage
            }
        } else {
            self.personImage.sd_setImage(with: URL(string: person.personImageURL))
        }
    }
    
}
