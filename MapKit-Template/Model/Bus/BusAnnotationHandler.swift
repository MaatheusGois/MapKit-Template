//
//  HandlerBus.swift
//  MapKit-Template
//
//  Created by Matheus Gois on 21/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import Foundation
import MapKit

enum BusAnnotationLoadResponse: Error {
    case success(bus: [BusAnnotation])
    case error(description: String)
}

class BusAnnotationHandler {
    static func fetchFromWeb(_ pesquisa:Int, completion: @escaping (BusAnnotationLoadResponse) -> Void) {
        
        let BASE_URL:String = "\(Server.url)/Posicao/Linha?codigoLinha=\(pesquisa)" //TODO
        
        //Valida a URL
        guard let url = URL(string: BASE_URL) else {
            completion(BusAnnotationLoadResponse.error(description: "URL not initiated"))
            return;
        }
        
        //Faz a chamada no Servidor
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            guard error == nil, let jsonData = data else {
                completion(BusAnnotationLoadResponse.error(description: "Error to unwrapp data variable"))
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
            
            if let object = json as? [String: Any] {
                for (key, value) in object {
                    if(key == "vs"){
                        var busArray = [BusAnnotation]()
                        if let value:[Any] = value as? [Any] {
                            if value.count != 0 {
                                for (value) in value {
                                    if let value:[String:Any] = value as? [String:Any] {
                                        
                                        let title = value["p"] as? String ?? ""
                                        let date = value["ta"] as? Date ?? Date()
                                        let lat = value["py"] as? CLLocationDegrees ?? 0
                                        let lon = value["px"] as? CLLocationDegrees ?? 0
                                        
                                        let bus = BusAnnotation(title: title, date: date,
                                                      coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
                                        
                                        busArray.append(bus)
                                    } else {
                                        completion(BusAnnotationLoadResponse.error(description: "Error to convert data to BusDAO"))
                                    }
                                }
                            }
                            completion(BusAnnotationLoadResponse.success(bus: busArray))
                        }
                    }
                }
            }
        }).resume()
    }
}
