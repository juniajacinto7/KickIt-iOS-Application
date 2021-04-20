//
//  ProfileViewController.swift
//  KickIt
//
//  Created by Julio C Lopez on 4/19/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileFirstName: UILabel!
    @IBOutlet weak var profileLastName: UILabel!
    @IBOutlet weak var profileUsername: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFUser.current()?.username
        print(profileUsername.text = query)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
