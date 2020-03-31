//
//  PersonCell.swift
//  Movies
//
//  Created by Ignacio Lima on 7/31/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {
    
    private struct keys {
        static let knownFor = "Known for:"
    }

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personDescription: UITextView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        personContentView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        personDescription.textContainerInset = UIEdgeInsets.zero
        personDescription.textContainer.lineFragmentPadding = 0
    }
    
    func cellSetup(person: Person) {
        selectionStyle = UITableViewCell.SelectionStyle.none
        backgroundColor = UIColor.cellBackground
        personName.text = person.personName
        personImage.sd_setImage(with: URL(string: person.personPhoto))
        let boldText = keys.knownFor
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let normalString = NSMutableAttributedString(string:person.knownFor)
        attributedString.append(normalString)
        personDescription.attributedText = attributedString
    }

}
