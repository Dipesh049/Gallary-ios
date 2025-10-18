//
//  SignInVC.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//

import UIKit
import GoogleSignIn

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            if let profile = signInResult?.user.profile {
                let user = UserModel(name: profile.name, image: profile.imageURL(withDimension: 400), email: profile.email)
                UserSessionManager.shared.setCurrentUser(user)
            }
            
            let tabbarController = TabBarController()
            self.view.window!.rootViewController = tabbarController
        }
    }
    
}
