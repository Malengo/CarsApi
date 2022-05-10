//
//  CarsTableViewController.swift
//  CarsApp
//
//  Created by Malengo on 10/05/22.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    var user : [UserEntity] = []
    var cars : [CarEntity] = []
    var dataUser : UserData = UserData()
    var request = RequestApi()
    var urlApi = "https://carros-springboot.herokuapp.com/api/v2/carros"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        getCars()
    }
    
    func getCars()  {
        if (dataUser.getToken() != ""){
            let response = request.getRequest(url: urlApi, method: "GET", token: dataUser.getToken())
            let tarefa =  URLSession.shared.dataTask(with: response){ [self]
                (dados, resposta, erro) in
                if((resposta as! HTTPURLResponse).statusCode == 200){
                    
                    if let dadosRetornados = dados{
                        do{
                            let decoder = try JSONDecoder().decode([CarEntity].self, from: dadosRetornados)
                            for data in decoder{
                                self.cars.append(data)
                            }
                            self.tableView.reloadData()
                            
                            }catch{
                            print("Erro ao converter dados")
                        }
                    }
                }else{
                    print("erro ao conectar ao servidor")
                }
                
            }
            
            tarefa.resume()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return "Lista de Carros"
       }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cars.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCars", for: indexPath) as! CarsCell
        
        cell.carName?.text = cars[indexPath.row].nome
        if let url = cars[indexPath.row].urlFoto{
            cell.imgCar.image = UIImage(data: NSData(contentsOf: NSURL(string: url)! as URL)! as Data)
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "InfoCar") as! InfoCarViewController
        vc.car = cars[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
