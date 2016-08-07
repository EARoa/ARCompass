//
//  ViewController.swift
//  ARCompass
//
//  Created by Efrain Ayllon on 8/5/16.
//  Copyright © 2016 Efrain Ayllon. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate {
    
    var cameraOverlay: UIView!
    var locationManager: CLLocationManager!
    var myCompass: UIImageView!
    var imagePickerViewController :UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker()
        camOverlay()
        locationUpdates()
        self.imagePickerViewController.cameraOverlayView = cameraOverlay
    }
    
    private func imagePicker(){
        self.imagePickerViewController = UIImagePickerController()
        self.imagePickerViewController.delegate = self
        self.imagePickerViewController.sourceType = .Camera
        self.imagePickerViewController.showsCameraControls = false
        self.imagePickerViewController.prefersStatusBarHidden()
    }
    
    private func camOverlay(){
        self.cameraOverlay = UIView(frame: CGRect(x: 0, y: 0, width: (self.view.frame.size.width), height: (self.view.frame.size.height)))
        self.myCompass = UIImageView(image: UIImage(named:"arrow.png"))
        myCompass.frame = CGRect(x: (self.view.frame.size.width/2)-50 , y: 200, width: 90, height: 100)
        let north = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)-25, y: 50, width: 100, height: 20))
        north.text = "North"
        north.textColor = UIColor.whiteColor()
        let south = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)-25, y: 400, width: 100, height: 20))
        south.text = "South"
        south.textColor = UIColor.whiteColor()
        let west = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)-150, y: 240, width: 100, height: 20))
        west.text = "West"
        west.textColor = UIColor.whiteColor()
        let east = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)+100, y: 240, width: 100, height: 20))
        east.text = "East"
        east.textColor = UIColor.whiteColor()
        self.cameraOverlay = UIView(frame: CGRect(x: 0, y: 0, width: (self.view.frame.size.width), height: (self.view.frame.size.height)))

        cameraOverlay.addSubview(north)
        cameraOverlay.addSubview(south)
        cameraOverlay.addSubview(east)
        cameraOverlay.addSubview(west)
        cameraOverlay.addSubview(myCompass)
    }
    
    private func locationUpdates(){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingHeading()
    }
    
    @IBAction func openButtonPressed() {
        self.presentViewController(self.imagePickerViewController, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let degrees = newHeading.magneticHeading
        let radians = degrees * M_PI / 180
        self.myCompass.transform = CGAffineTransformMakeRotation(CGFloat(-radians))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
