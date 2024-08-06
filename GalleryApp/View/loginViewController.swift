//
//  ViewController.swift
//  GalleryApp
//
//  Created by Amit rai on 29/07/24.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class loginViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
      override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          if Auth.auth().currentUser != nil {
              navigateToHome()
          }
      }

  
    @IBAction func googleingninbutton(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
                      if let error = error {
                          print("There is an error signing the user in ==> \(error)")
                          return
                      }
                      guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
                      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                      
            Auth.auth().signIn(with: credential) { [self] authResult, error in
                          if let error = error {
                              print(error)
                          } else {
                          
                              print(authResult?.user.email ?? "No Email")
                              print(authResult?.user.displayName ?? "No Display Name")
                            self.navigateToHome()
                          }
                      }
                  }
          }
          
          private func navigateToHome() {
            let vc =  (storyboard?.instantiateViewController(identifier: "galleryvc"))! as galleryViewController
            navigationController?.pushViewController(vc, animated: true)
              }
          
          
      }
