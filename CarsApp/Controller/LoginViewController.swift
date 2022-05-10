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
    
    var request = RequestApi()
    var userData = UserData()
    var urlApi : String = "https://carros-springboot.herokuapp.com/api/v2/login"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !userData.getToken().isEmpty {
            pushView()
        }
    }
    
    @IBAction func loginUser(_ sender: Any) {
        
       if loginText.text!.isEmpty || passwordText.text!.isEmpty {
            messageAlert("Login e Senha deve estar preenchidos")
        } else if getUserApi(loginText.text!, passwordText.text!) {           
           pushView()
        }
    }
    
    func pushView(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "carsTableList") as! CarsTableViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getUserApi(_ login: String, _ password: String) -> Bool {
        var complete = true
        var response = request.getRequest(url: urlApi, method: "POST", token: "")
        let userLogin = LoginEntity();
        
        userLogin.username = login
        userLogin.password = password
        
        do {
            try response.httpBody = JSONEncoder().encode(userLogin)
        } catch {
            print ("Erro ao converter")
        }
        let tarefa =  URLSession.shared.dataTask(with: response){ [self]
            (dados, resposta, erro) in
            if((resposta as! HTTPURLResponse).statusCode == 200){
                
                if let dadosRetornados = dados{
                    do{
                        let decoder = try JSONDecoder().decode(UserEntity.self, from: dadosRetornados)
                        var user = UserEntity()
                        user = decoder
                        print(user.token!)
                        //userData.salve(user: user)
                       
                    }catch{
                        print("Erro ao converter dados")
                    }
                    
                }
            }else{
               messageAlert("Login ou Senha Inválidos!")
                complete = false
                print("erro")
            }
            
        }
        
        tarefa.resume()
        return complete
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
