//
//  CarsTableViewController.swift
//  CarsApp
//
//  Created by Malengo on 10/05/22.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    var cars: [CarEntity]?
    var carApi = CarApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCars()
        self.navigationItem.hidesBackButton = true
    }
    
    func getCars()  {
        Task {
            self.cars = try await carApi.getAllCar()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
        return cars?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCars", for: indexPath) as! CarsCell
        
        cell.carName?.text = cars?[indexPath.row].nome
        
        if let newUrl = URL(string: self.cars?[indexPath.row].urlFoto ?? "") {
            let request = URLRequest(url: newUrl)
            Task {
                let image = UIImage()
                cell.imgCar.image = try await image.loadImageData(request)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "InfoCar") as! InfoCarViewController
        vc.car = cars?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension UIImage {
    func loadImageData(_ request: URLRequest) async throws -> UIImage {
        var image: UIImage
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { throw NSError.init(domain: "Error", code: 1)}
            guard httpResponse.statusCode == 200  else { throw NSError.init(domain: "Error", code: 2)}
            
            image = UIImage(data: data)!
            return image
        } catch {
            return UIImage()
        }
        
    }
}
