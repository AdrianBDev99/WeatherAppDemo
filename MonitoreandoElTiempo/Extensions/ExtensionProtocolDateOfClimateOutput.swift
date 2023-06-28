//
//  protocolDateOfClimateOutput.swift
//  MonitoreandoElTiempo
//
//  Created by Adrian Bello Cahuantzi on 27/06/23.
//

import Foundation

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
