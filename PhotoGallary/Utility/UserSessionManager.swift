//
//  UserSessionManager.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//

import GoogleSignIn

final class UserSessionManager {
    static let shared = UserSessionManager()
    
    private init() {}
    
    private(set) var currentUser: UserModel?
    
    func setCurrentUser(_ user: UserModel) {
        self.currentUser = user
        saveToDefaults(user)
    }
    
    func loadPreviousSession() -> Bool {
        if let data = UserDefaults.standard.data(forKey: "loggedInUser"),
           let user = try? JSONDecoder().decode(UserModel.self, from: data) {
            self.currentUser = user
            return true
        }
        return false
    }
    
    func logout() {
        currentUser = nil
        CoreDataManager.shared.deletePhotos()
        UserDefaults.standard.removeObject(forKey: "loggedInUser")
        GIDSignIn.sharedInstance.signOut()
    }
    
    private func saveToDefaults(_ user: UserModel) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: "loggedInUser")
        }
    }
}
