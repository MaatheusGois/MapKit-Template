//
//  ViewController.swift
//  MapKit-Template
//
//  Created by Matheus Gois on 21/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    var timer:Timer!
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    var prefixOfBus = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authSPTrans(){
            (res,err) in
            
            self.takePosition(self.prefixOfBus, completion: { (bus) in
                if bus != nil {
                    let initialLocation = CLLocation(latitude: bus?.coordinate.latitude ?? 0,
                                                     longitude: bus?.coordinate.longitude ?? 0)
                    
                    self.centerMapOnLocation(location: initialLocation)
                    self.mapView.addAnnotation(bus!)
                    self.updatePosition()
                }
            })
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func takePosition(_ prefixo: Int, completion: @escaping (BusAnnotation?) -> Void ) {
        BusAnnotationHandler.fetchFromWeb(prefixo) { (res) in
            switch (res) {
            case .success(let bus):
                if bus.count >= 1 {
                    completion(bus[0])
                }
            case .error(let description):
                print(description)
                completion(nil)
            }
        }
    }
    
    private func updatePosition(){
        //Update the state every 10 seconds
        let date = Date().addingTimeInterval(0)
        self.timer = Timer(fireAt: date, interval: 1, target: self, selector: #selector(setNewPosition), userInfo: nil, repeats: true)
        
        
        DispatchQueue.main.async {
            RunLoop.main.add(self.timer, forMode: .default)
        }
        
    }
    
    @objc private func setNewPosition(){
        self.takePosition(prefixOfBus) { (bus) in
            if bus != nil {
                for existingMarker in self.mapView.annotations {
                    if let annotation = existingMarker as? BusAnnotation {
                        print( (bus?.coordinate.latitude) ?? 0   , bus?.coordinate.longitude ?? 0)
                        annotation.coordinate = CLLocationCoordinate2D(latitude: (bus?.coordinate.latitude) ?? 0   , longitude: bus?.coordinate.longitude ?? 0)
                    }
                }
                
            } else {
                print("Error in setNewPosition")
            }
        }
        
    }
    @objc func nextPage(){
        performSegue(withIdentifier: "seeMap", sender: nil)
    }
    
    
}

