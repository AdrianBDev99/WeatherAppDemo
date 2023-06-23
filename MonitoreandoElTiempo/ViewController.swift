//
//  ViewController.swift
//  MonitoreandoElTiempo
//
//  Created by Adrian Bello Cahuantzi on 20/06/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var viewOne: UIView!
    
    @IBOutlet weak var viewTwo: UIView!
    
    
    @IBOutlet weak var viewTree: UIView!
    
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var descriptionClimateLbl: UILabel!
    
    @IBOutlet weak var temperaturaLbl: UILabel!
    
    @IBOutlet weak var speedVientoLbl: UILabel!
    
    @IBOutlet weak var humidityLbl: UILabel!
    
    @IBOutlet weak var speedVisibilityLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    
    
    var locationManager: CLLocationManager!
    
    
    var myDictionary: [Int:String] = [0 : "Amanecer", 1: "Atardecer"]
    
    var myModelTable = [modelAmanecerAtardecer]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        DateOfClimate.shared.delegateDateOfClimate = self
        tableView.delegate = self
        tableView.dataSource = self
        createDateTime1(timestamp: "1687435244")
        createDateTime2(timestamp: "1687483017")
        
        //Comentario de prueba para git
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, aaaa"
        formatter.locale = Locale (identifier: "es_MX")
        formatter.dateStyle = .long
        dateLbl.text = formatter.string(from: date)
        
        
        
        viewOne.layer.borderWidth = 1
        viewOne.layer.borderColor = UIColor.black.cgColor
        
        
        viewTwo.layer.borderWidth = 1
        viewTwo.layer.borderColor = UIColor.black.cgColor
        
        viewTree.layer.borderWidth = 1
        viewTree.layer.borderColor = UIColor.black.cgColor
         
        
        
    }
   
    func createDateTime1(timestamp: String) -> String {
        var strDate = "undefined"
            
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
            dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "HH:mm" //Specify your format that you want
            strDate = dateFormatter.string(from: date)
        }
            
        return strDate
    }
    
    func createDateTime2(timestamp: String) -> String {
        var strDate2 = "undefined"
            
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
            dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "HH:mm" //Specify your format that you want
            strDate2 = dateFormatter.string(from: date)
        }
            
        return strDate2
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myModelTable.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell (style: .value1, reuseIdentifier: "cell")
        
        
        //Forma para mostrar propiedad en la celda
        cell.textLabel?.text = myModelTable[indexPath.row].titleModel
        cell.detailTextLabel?.text = myModelTable[indexPath.row].hourString
        return cell
    }
    
    
    func confView(_ model: ResponseWeather) {
        DispatchQueue.main.async {
            self.nameLbl.text = model.name
            self.descriptionClimateLbl.text = model.weather.first!.description
            self.temperaturaLbl.text = "\(String(model.main.temp))º"
            self.speedVientoLbl.text = "\(String(model.wind.speed))Km/h"
            self.humidityLbl.text = "\(String(model.main.humidity))%"
            self.speedVisibilityLbl.text = "\(String(model.visibility))m/s"
            self.myModelTable.append(modelAmanecerAtardecer(titleModel: "Amanecer", hourString: self.createDateTime1(timestamp: "1687434945")))
            self.myModelTable.append(modelAmanecerAtardecer(titleModel: "Atardecer", hourString: self.createDateTime2(timestamp: "1687482798")))
            
            //Recargo la tabla
            self.tableView.reloadData()
            
        }
    }

}
extension ViewController: DateOfClimateOutput {
    func succesResponse(_ model: ResponseWeather) {
        DispatchQueue.main.async {
            self.confView(model)
            
            
        }
    }
    
    func failedResponse(_ message: String) {
    print(message)
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status  == .authorizedAlways {
            guard let coor = locationManager.location else {return}
            let lat = Double(coor.coordinate.latitude)
            let lon = Double(coor.coordinate.longitude)
            DateOfClimate.shared.doRequest(lat: lat, long: lon)
        
        }
        
    }
}



