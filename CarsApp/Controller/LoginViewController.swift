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
    }
    
    @IBAction func loginUser(_ sender: Any) {
        
       if loginText.text!.isEmpty || passwordText.text!.isEmpty {
            messageAlert("Login e Senha devem estar preenchidos")
       } else if request.getUserApi(loginText.text!, passwordText.text!) {           
           pushView()
        }
    }
    
    func pushView(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "carsTableList") as! CarsTableViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    func messageAlert(_ textMsg : String){
        let alert = UIAlertController(title: "Erro", message: textMsg , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
