//
//  Request.swift
//  MapKit-Template
//
//  Created by Matheus Gois on 21/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import Foundation

func getDishes(_ url: String) {
    do {
        if let file = URL(string: url) {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                
                print(object)
                
            } else if let object = json as? [Any] {
                
                for anItem in object as! [Dictionary<String, AnyObject>] {
                    if ((anItem["name"] != nil) && (anItem["_id"] != nil)){
                        
                        let name = anItem["name"] as! String
                    }
                }
            } else {
                print("JSON is invalid")
            }
        } else {
            print("no file")
        }
    } catch {
        print(error.localizedDescription)
    }
}


func authSPTrans(completion: @escaping (Bool?, Error?) -> Void){

    if let URL = URL(string: Server.url + "/Login/Autenticar?token=" + Server.token) {
        let request = NSMutableURLRequest(url: URL)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            do {
                if let data = data {
                    let response = try JSONSerialization.jsonObject(with: data, options: [])
                    print(response)
                    completion(true, nil)
                }
                else {
                    print("err")
                    completion(false, nil)
                }
            } catch let error as NSError {
                completion(false, nil)
                print("Error")
                print("json error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    else{
        completion(false, nil)
        print("Error")
    }
}
