//
//  ProfileViewController.swift
//  KickIt
//
//  Created by Julio C Lopez on 4/19/21.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileFirst: UILabel!
    @IBOutlet weak var profileLast: UILabel!
    @IBOutlet weak var profileUsername: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
     
        let query1 = PFUser.current()?.username
        let query2 = PFUser.current()
        profileFirst.text = query2?["firstname"] as? String
        profileLast.text = query2?["lastname"] as? String
        profileUsername.text = query1
        
        if query2?["image"] as? PFFileObject != nil {
        let imageFile = query2?["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        profilePicture.af.setImage(withURL: url)
        
        }
        
        let query = PFQuery(className: "Bookmark")
        query.whereKey("author", equalTo: PFUser.current()!)
        query.findObjectsInBackground { (comments: [PFObject]?, error: Error?) in
            if let error = error {
                // The request failed
                print("error")
            } else {
                print("we did it")
                // comments now contains the comments for myPost
            }
        }

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
