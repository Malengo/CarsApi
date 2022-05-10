//
//  InfoCarViewController.swift
//  CarsApp
//
//  Created by Malengo on 10/05/22.
//

import UIKit

class InfoCarViewController: UIViewController {
    
    var car : CarEntity = CarEntity()

    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var typeText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = car.nome
        self.typeText.text = car.tipo
        self.descriptionText.text = car.descricao
        self.imgCar.image = UIImage(data: NSData(contentsOf: NSURL(string: car.urlFoto!)! as URL)! as Data)
      
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MapViewController
        if let lat = self.car.latitude{
            vc.lat = Double(lat)!
        }
        if let long = self.car.longitude{
            vc.long = Double(long)!
        }
       
    }
    

}
