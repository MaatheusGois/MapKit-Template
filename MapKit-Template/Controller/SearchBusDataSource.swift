//
//  SearchBarDataSource.swift
//  MapKit-Template
//
//  Created by Matheus Gois on 22/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit

class SearchBusDataSource: NSObject, UITableViewDataSource {
    
    var bus = [Bus]()
    
    init(bus: [Bus]) {
        self.bus = bus
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "busCell") as? SearchBusTableViewCell else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = "Error"
            return cell
        }
        let bus = self.bus[indexPath.row]
        
        
        let title = (bus.sl == 1) ? "\(bus.tp) -> \(bus.ts)" : "\(bus.ts) -> \(bus.tp)"
        let subtitle = "\(bus.lt)-\(bus.tl)"
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        return cell
    }
    
    
}
