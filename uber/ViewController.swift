//
//  ViewController.swift
//  uber
//
//  Created by miguel tomairo on 2/9/19.
//  Copyright © 2019 miguel tomairo. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTexField: UITextField!
    @IBOutlet weak var riderDriverSwitch: UISwitch!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    var signUpMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hideKeyboardWhenTappedAround()
        
    }
    
    func closeSesion(){
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError)")
        } catch {
            print("Unknown error.")
        }
    }

    @IBAction func signUpTapped(_ sender: Any) {
        

        Auth.auth().createUser(withEmail: userTextField.text!, password: passwordTexField.text!) { (authResult, error) in
            
            guard let user = authResult?.user else { return }
            
            print("Succesful")
        }

    }
    
    @IBAction func logInTapped(_ sender: Any) {
        

        Auth.auth().signIn(withEmail: userTextField.text!, password: passwordTexField.text!) { (authDataResult, error) in
 
            if error != nil{
                print(error.debugDescription)
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                self.present(vc, animated: true, completion: nil)
            }
            
        }
        
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
