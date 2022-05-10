//
//  MapViewController.swift
//  CarsApp
//
//  Created by Malengo on 10/05/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapCar: MKMapView!
    
    var long : Double = 0.0
    var lat : Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(long, lat)
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: lat , longitude: long )
        annotation.coordinate = centerCoordinate
        annotation.title = "Title"
        mapCar.addAnnotation(annotation)

        // Do any additional setup after loading the view.
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
