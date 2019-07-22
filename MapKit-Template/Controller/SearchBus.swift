//
//  SearchBus.swift
//  MapKit-Template
//
//  Created by Matheus Gois on 22/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import UIKit

class SearchBus: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var bus = [Bus]()
    
    
    @IBOutlet weak var searchBar: UITextField!
    
    //Create DataSource
    let dataSource: SearchBusDataSource = SearchBusDataSource(bus: [])
    
    
    @IBAction func searchButtonBar(_ sender: Any) {
        guard let search:String = searchBar.text else {
            return
        }
        
        //Show loading
        self.showSpinner(onView: self.view)
        //Hide Keyboard
        self.dismissKeyboard()
        
        authSPTrans(){
            (res,err) in
            //Fetch books from web
            BusHandler.fetchFromWeb(search) { (res) in
                switch (res) {
                case .success(let bus):
                    self.bus = bus
                    //Async reload
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.removeSpinner()
                    }
                case .error(let description):
                    print(description)
                    self.removeSpinner()
                }
            }
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("here")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "seeMap", sender: nil)
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
        
        cell.seeInMap.tag = indexPath.row
        cell.seeInMap.addTarget(self, action: #selector(seeMap(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Hide Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil {
            if segue.identifier! == "seeMap" {
                guard let sender: UIButton = sender as? UIButton else { return }
                (segue.destination as! MapViewController).prefixOfBus = self.bus[sender.tag].cl
            }
        }
    }
    
    @objc func seeMap(sender:UIButton){
        performSegue(withIdentifier: "seeMap", sender: sender)
    }
}
