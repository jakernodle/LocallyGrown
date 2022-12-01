//
//  AuthenticationViewModel.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/7/22.
//

import Foundation
import GoogleSignIn
import Combine

class AuthenticationViewModel: ObservableObject {
    
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    
    private var shouldDismissView = false {
        didSet {
            viewDismissalModePublisher.send(shouldDismissView)
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = testStr.range(of: emailRegEx, options: .regularExpression)
        let result = range != nil ? true : false
        return result
    }
    
    func isValidName(testStr:String) -> Bool {
        let nameRegEx = "([A-Za-z ]+)"
        let range = testStr.range(of: nameRegEx, options: .regularExpression)
        let result = range != nil ? true : false
        return result
    }
    
    func signup(name: String, email: String, password: String){
        guard isValidEmail(testStr: email) else {
            print("bad email")
            return
        }
        
        guard isValidName(testStr: name) else {
            print("bad name")
            return
        }
        
        let user = self.createUser(name: name, email: email)
        LocallyGrownShopper.shared.login(user: user) //TODO: login user service
        self.shouldDismissView = true
    }
    
    func continueWithGoogle(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                print("error from google sign in: \(error.localizedDescription)")
            }
            
            if let name = user?.profile?.givenName, let email = user?.profile?.email, let pictureUrl = user?.profile?.imageURL(withDimension: 200)!.absoluteString{
                let user = self.createUser(name: name, email: email, pictureUrlString: pictureUrl)
                LocallyGrownShopper.shared.login(user: user) //TODO: login user service
                self.shouldDismissView = true
            }else{
                self.showSignIn()
            }
        }
    }
    
    func showSignIn() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        let signInConfig = GIDConfiguration(clientID: "191952635625-ncu40r9iqep4uqqjuu21ui7h3lmk7d27.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig,
            presenting: presentingViewController,
            callback: { user, error in
                if let error = error {
                    print("error",error)
                }
                if let name = user?.profile?.givenName, let email = user?.profile?.email, let pictureUrl = user?.profile?.imageURL(withDimension: 200)!.absoluteString{
                    let user = self.createUser(name: name, email: email, pictureUrlString: pictureUrl)
                    LocallyGrownShopper.shared.login(user: user) //TODO: login user service
                    self.shouldDismissView = true
                }else{
                    print("error signing in with google")
                }
            }
        )
    }
    
    func createUser(name: String, email: String, pictureUrlString: String? = nil) -> Shopper {
        return Shopper(id: "1", name: name, email: email, pictureURL: pictureUrlString, favoriteFarmIds: [], orders: [], carts: [:])
    }
}
