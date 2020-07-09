//
//  ViewController.swift
//  Weather Map
//
//  Created by Samyak Pawar on 08/07/20.
//  Copyright © 2020 ArtistSamyak. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var location: UILabel!
    
    
    @IBOutlet weak var desc: UILabel!
    
    
    @IBOutlet weak var temp: UILabel!
    
    let locationManager = CLLocationManager()
    
    var l = ""
    var d = ""
    var t = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        location.text = ""
        desc.text = ""
        temp.text = ""
    }
    
    func GetInfo(Lat: Double, Lon: Double) {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=" + String(Lat) + "&lon=" + String(Lon) + "&appid=d15f2a7a7210e09094bed92c19b51846&units=metric")
        let session = URLSession(configuration: .default)
        
        
        
        let task = session.dataTask(with: url!) { (data, urlResponce, error) in
            let decoder = JSONDecoder()
            let decodedData = try! decoder.decode(WeatherData.self, from: data!)
            
            let location: String = String(decodedData.name) + ", " + String(decodedData.sys.country)
            let temperature: String  = String(decodedData.main.temp) + "°C"
            let description = decodedData.weather[0].description
            
            self.l = location
            self.d = description
            self.t = temperature
            
        }
        task.resume()
        
    }
    
    
}



var toGetData = true

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if toGetData == true {

            toGetData = false
            //get data
            let latitude = mapView.centerCoordinate.latitude
            let longitude = mapView.centerCoordinate.longitude
            GetInfo(Lat: latitude, Lon: longitude)
            
            let seconds = 0.8
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.location.text = self.l
                self.desc.text = self.d
                self.temp.text = self.t
                toGetData = true
            }
    
        }else {
            //do nothing.
        }
        
    }

}
  


