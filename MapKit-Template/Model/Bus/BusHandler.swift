//
//  BusHandler.swift
//  MapKit-Template
//
//  Created by Matheus Gois on 22/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import Foundation
import MapKit

enum BusLoadResponse: Error {
    case success(bus: [Bus])
    case error(description: String)
}

class BusHandler {
    static func fetchFromWeb(_ pesquisa:String, completion: @escaping (BusLoadResponse) -> Void){
        
        let urlString:String = pesquisa.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" //TODO
        let BASE_URL:String = "\(Server.url)/Linha/Buscar?termosBusca=\(String(describing: urlString))" //TODO
        //Valida a URL
        guard let url = URL(string: BASE_URL) else {
            completion(BusLoadResponse.error(description: "URL not initiated"))
            return
        }
        
        //Faz a chamada no Servidor
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            guard error == nil, let jsonData = data else {
                completion(BusLoadResponse.error(description: "Error to unwrapp data variable"))
                return
            }
            
            if let bus = try? JSONDecoder().decode([Bus].self, from: jsonData) {
                completion(BusLoadResponse.success(bus: bus))
            }
            else {
                completion(BusLoadResponse.error(description: "Error to convert data to [Bus]"))
            }
        }).resume()
    }
}
