//
//  ExtensionCLLocationManagerDelegate.swift
//  MonitoreandoElTiempo
//
//  Created by Adrian Bello Cahuantzi on 27/06/23.
//

import Foundation
import CoreLocation

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
