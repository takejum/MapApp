//
//  ViewController.swift
//  MapApp
//
//  Created by Jumpei Takeshita on 2020/03/26.
//  Copyright © 2020 Jumpei Takeshita. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, searchLocationDelegate {

    var addressString:String!
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var locaManager:CLLocationManager!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton.backgroundColor = .white
        setButton.layer.cornerRadius = 20.0
    }
    
    func convert(lat: CLLocationDegrees, long:CLLocationDegrees){
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude:lat, longitude: long)
        geocoder.reverseGeocodeLocation(location){ (placeMark, error) in
            if let pm = placeMark?.first{
                if pm.administrativeArea != nil || pm.locality != nil {
                    self.addressString = pm.name! + pm.administrativeArea! +  pm.locality!
                }else{
                    self.addressString = pm.name!
                }
                self.addressLabel.text = self.addressString
            }
        }
    }

    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        
        //when it's tapped
        if sender.state == .began {
            
        
        //when tapping ended
        }else if sender.state == .ended{
            
            //end tapping
            
            //retrieve lat&long by designating where is touched
            
            //convert lat&long data to address data
            let tapPoint = sender.location(in: view)
            
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            let lat = center.latitude
            let long = center.longitude
            convert(lat: lat, long: long)
            
        }
    }
    
    @IBAction func goToSearchVC(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "next" {
            let searchVC = segue.destination as! SecondViewController
            searchVC.delegate = self
        }
        
    }
    func searchLocation(longValue: String, latValue: String) {
        if longValue.isEmpty != true && latValue.isEmpty != true {
            let longString = longValue
            let latString = latValue
            
            //cordinate from the data of long&lat
            let cordinate = CLLocationCoordinate2DMake(Double(longString)!, Double(latString)!)
            
            //designate which part of map to show
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            //designate the realm
            let region = MKCoordinateRegion(center: cordinate, span: span)
            //setting the realm in the mapView
            mapView.setRegion(region, animated: true)
            //convert long&lat into address
            convert(lat: Double(latString)!, long: Double(longString)!)
            
            addressLabel.text = addressString
            
        }else{
            addressLabel.text = "impossible to show."
            
        }
    }
    
}

