//
//  ProfileVC.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = UserSessionManager.shared.currentUser {
            lblName.text = "Name: \(user.name ?? "")"
            lblEmail.text = "Email: \(user.email ?? "")"
            ImageLoader.shared.loadImage(from: user.image?.absoluteString ?? "") { [weak self] image in
                if let img = image {
                    self?.imgViewProfile.image = img
                } else {
                    self?.imgViewProfile.image = UIImage(systemName: "person.circle")
                }
            }
        }
    
    }
    
    /// sign out butto  action 
    @IBAction func signOut(_ sender: UIButton) {
        UserSessionManager.shared.logout()
        let signInVC = SignInVC()
        self.view.window?.rootViewController = signInVC
        self.view.window?.makeKeyAndVisible()
    }
    
}
