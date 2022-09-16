//
//  ViewController.swift
//  Project16
//
//  Created by Erik Radicheski da Silva on 16/09/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), url: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), url: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), url: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), url: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington D.C.", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), url: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Capital")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .action, primaryAction: UIAction { [weak self] _ in
            let ac = UIAlertController(title: nil, message: "Choose your map", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: self?.changeMapType(_:)))
            ac.addAction(UIAlertAction(title: "Image", style: .default, handler: self?.changeMapType(_:)))
            ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: self?.changeMapType(_:)))
            self?.present(ac, animated: true)
        })
    }
    
    func changeMapType(_ sender: UIAlertAction) {
        switch sender.title {
        case "Standard": mapView.preferredConfiguration = MKStandardMapConfiguration()
        case "Image": mapView.preferredConfiguration = MKImageryMapConfiguration()
        case "Hybrid": mapView.preferredConfiguration = MKHybridMapConfiguration()
        default: return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowDetail" else {
            super.prepare(for: segue, sender: sender)
            return
        }
        
        if let viewController = segue.destination as? DetailViewController,
           let capital = sender as? Capital {
            viewController.capital = capital
        }
    }


}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
            as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        annotationView.markerTintColor = .orange
        annotationView.canShowCallout = true
        let button = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = button
        
        return annotationView
    
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        performSegue(withIdentifier: "ShowDetail", sender: capital)
    }
    
}
