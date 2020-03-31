//
//  PersonInfoViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 8/7/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class PersonInfoViewController: UIViewController {
    
    @IBOutlet weak var knFor: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var knCredits: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var pOfBirth: UILabel!
    
    private struct keys {
        static let undefined = "Undefined"
        static let female = "Female"
        static let male = "Male"
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    var person: Person? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(person?.gender == 0) {
            gender.text = keys.undefined
        } else if(person?.gender == 1) {
            gender.text = keys.female
        } else if(person?.gender == 2) {
            gender.text = keys.male
        }
        knFor.text = person?.knownForDepartment
        knCredits.text = String(person!.popularity)
        birthday.text = person?.birthday
        pOfBirth.text = person?.placeOfBirth
    }

}
