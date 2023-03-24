//
//  InfoCarViewController.swift
//  CarsApp
//
//  Created by Malengo on 10/05/22.
//

import UIKit

class InfoCarViewController: UIViewController {
    
    var car: CarEntity?
    
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var typeText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setupLayout() {
        if let car {
            self.navigationItem.title = car.nome
            self.typeText.text = car.tipo
            self.descriptionText.text = car.descricao
            if let newURL = URL(string: car.urlFoto ?? "") {
                let request = URLRequest(url: newURL)
                Task {
                    let (data, _) = try await URLSession.shared.data(for: request)
                    self.imgCar.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MapViewController
        if let lat = self.car?.latitude{
            vc.lat = Double(lat)!
        }
        if let long = self.car?.longitude{
            vc.long = Double(long)!
        }
        
    }
}
