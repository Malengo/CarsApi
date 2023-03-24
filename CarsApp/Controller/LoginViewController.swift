//
//  LoginViewController.swift
//  CarsApp
//
//  Created by Malengo on 09/05/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var request = UserApi()
    var userData = UserData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !userData.getToken().isEmpty {
            pushView()
        }
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func loginUser(_ sender: Any) {
        
        if let login = loginText.text, let password = passwordText.text {
            if !login.isEmpty && !password.isEmpty {
                let user = LoginEntity(username: login, password: password)
                Task {
                    let result = await request.getUserApi(user)
                    DispatchQueue.main.async {
                        if result {
                            self.pushView()
                        } else {
                            self.messageAlert("Dados incorretos")
                        }
                    }
                }
            } else {
                messageAlert("Preencha os Campos")
            }
        }
    }
    
    func pushView(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "carsTableList") as! CarsTableViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func messageAlert(_ textMsg: String){
        let alert = UIAlertController(title: "Erro", message: textMsg , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}
