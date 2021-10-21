//
//  ViewController.swift
//  GyroscopeAccelerometerPractice
//
//  Created by Caroline LaDouce on 10/20/21.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var xGradientLayer: CAGradientLayer = {
        var layer = CAGradientLayer()
        layer.type = .axial
        layer.colors = [
            UIColor(red: 89/255, green: 148/255, blue: 116/255, alpha: 1).cgColor,
            UIColor(red: 236/255, green: 177/255, blue: 135/255, alpha: 1).cgColor
        ]
        layer.opacity = 0.5
        
        return layer
    }()
    
    
    var yGradientLayer: CAGradientLayer = {
        var layer = CAGradientLayer()
        layer.type = .axial
        layer.startPoint = CGPoint(x: 0, y: 1)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.colors = [
            UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1).cgColor,
            UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1).cgColor
        ]
        layer.opacity = 0.5
        
        return layer
    }()
    
    
    var zGradientLayer: CAGradientLayer = {
        var layer = CAGradientLayer()
        layer.type = .radial
        layer.startPoint = CGPoint(x: 0.5, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.colors = [
            UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1).cgColor,
            UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1).cgColor
        ]
        layer.opacity = 0.5

        return layer
    }()
    
    
    // Acceleration & rotation variables:
    var xAcceleration: Double = 0.0
    var yAcceleration: Double = 0.0
    var zAcceleration: Double = 0.0
    var xRotation: Double = 0.0
    var yRotation: Double = 0.0
    var zRotation: Double = 0.0
    
    let motionManager = CMMotionManager()
    
    
    // Display labels:
    var xAccelerationLabel = UILabel()
    var yAccelerationLabel = UILabel()
    var zAccelerationLabel = UILabel()
    var xRotationLabel = UILabel()
    var yRotationLabel = UILabel()
    var zRotationLabel = UILabel()
    
    var motionDataFetchTimer = Timer()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        
        view.layer.addSublayer(zGradientLayer)
        view.layer.addSublayer(yGradientLayer)
        view.layer.addSublayer(xGradientLayer)
        
        
        view.addSubview(xAccelerationLabel)
        xAccelerationLabel.text = "X Acceleration: \(xAcceleration)"
        xAccelerationLabel.translatesAutoresizingMaskIntoConstraints = false
        xAccelerationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        xAccelerationLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -300).isActive = true
        
        view.addSubview(yAccelerationLabel)
        yAccelerationLabel.text = "Y Acceleration: \(yAcceleration)"
        yAccelerationLabel.translatesAutoresizingMaskIntoConstraints = false
        yAccelerationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yAccelerationLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        
        view.addSubview(zAccelerationLabel)
        zAccelerationLabel.text = "Z Acceleration: \(zAcceleration)"
        zAccelerationLabel.translatesAutoresizingMaskIntoConstraints = false
        zAccelerationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        zAccelerationLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        
        view.addSubview(xRotationLabel)
        xRotationLabel.text = "X Rotation: \(xRotation)"
        xRotationLabel.translatesAutoresizingMaskIntoConstraints = false
        xRotationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        xRotationLabel.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(yRotationLabel)
        yRotationLabel.text = "Y Rotation: \(yRotation)"
        yRotationLabel.translatesAutoresizingMaskIntoConstraints = false
        yRotationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yRotationLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        
        view.addSubview(zRotationLabel)
        zRotationLabel.text = "Z Rotation: \(zRotation)"
        zRotationLabel.translatesAutoresizingMaskIntoConstraints = false
        zRotationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        zRotationLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 200).isActive = true
        
        
        // Set motion manager properties
        motionManager.accelerometerUpdateInterval = 1
        motionManager.gyroUpdateInterval = 1
        
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        
        startDeviceMotion()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let data = self.motionManager.accelerometerData {
                self.xAcceleration = data.acceleration.x
                self.yAcceleration = data.acceleration.y
                self.zAcceleration = data.acceleration.z
                
                self.xAccelerationLabel.text = "X Acceleration: \(self.xAcceleration)"
                self.yAccelerationLabel.text = "Y Acceleration: \(self.yAcceleration)"
                self.zAccelerationLabel.text = "Z Acceleration: \(self.zAcceleration)"
            }
            
            if let gyroData = self.motionManager.gyroData {
                self.xRotation = gyroData.rotationRate.x
                self.yRotation = gyroData.rotationRate.y
                self.zRotation = gyroData.rotationRate.z
                
                self.xRotationLabel.text = "X Rotation: \(self.xRotation)"
                self.yRotationLabel.text = "Y Rotation: \(self.yRotation)"
                self.zRotationLabel.text = "Z Rotation: \(self.zRotation)"
            }
            
        }
        
        self.view = view
        
    } // End viewDidLoad
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        zGradientLayer.frame = self.view.bounds
        yGradientLayer.frame = self.view.bounds
        xGradientLayer.frame = self.view.bounds
    }
    
    
    // disable screen auto rotate
    override open var shouldAutorotate: Bool {
        return false
    }
    
    
    // Fetching device motion data "on demand"
    // This data will disclude bias such as gravity
    func startDeviceMotion() {
        if motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 1.0
            self.motionManager.showsDeviceMovementDisplay = true
            self.motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            // Set timer to fetch motion data
            motionDataFetchTimer = Timer(fire: Date(), interval: (1.0), repeats: true, block: { (timer) in
                if let data = self.motionManager.deviceMotion {
                    
                    self.xAcceleration = data.userAcceleration.x
                    self.yAcceleration = data.userAcceleration.y
                    self.zAcceleration = data.userAcceleration.z
                    
                    self.xAccelerationLabel.text = "X Acceleration: \(self.xAcceleration)"
                    self.yAccelerationLabel.text = "Y Acceleration: \(self.yAcceleration)"
                    self.zAccelerationLabel.text = "Z Acceleration: \(self.zAcceleration)"
                    
                    
                    
                    self.xRotation = data.attitude.pitch
                    self.yRotation = data.attitude.roll
                    self.zRotation = data.attitude.yaw
                    
                    self.xRotationLabel.text = "X Rotation: \(self.xRotation)"
                    self.yRotationLabel.text = "Y Rotation: \(self.yRotation)"
                    self.zRotationLabel.text = "Z Rotation: \(self.zRotation)"
                    
                    self.animateBackgroundColor()
                    
                }
            })
            
            RunLoop.current.add(self.motionDataFetchTimer, forMode: RunLoop.Mode.default)
        }
    }
    
    
    // Animate the background color change
    func animateBackgroundColor() {
        UIView.animate(withDuration: 1) {
            //self.zRotationAnimate()
            self.yRotationAnimate()
            self.xRotationAnimate()
        }
    } // End func
    
    
    func zRotationAnimate() {
        if self.zRotation < 0 {
            self.zGradientLayer.colors = [
                UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1).cgColor,
                UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1).cgColor
            ]
        } else if self.zRotation > 0 {
            self.zGradientLayer.colors = [
                UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1).cgColor,
                UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1).cgColor
            ]
        } else {
            self.zGradientLayer.colors = [
                UIColor.systemGray,
                UIColor.lightGray
            ]
        }
    } // End func
    
    
    func yRotationAnimate() {
        if self.yRotation < 0 {
            self.yGradientLayer.colors = [
                UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1).cgColor,
                UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1).cgColor
            ]
        } else if self.yRotation > 0 {
            self.yGradientLayer.colors = [
                UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1).cgColor,
                UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1).cgColor
            ]
        } else {
            self.yGradientLayer.colors = [
                UIColor.systemGray,
                UIColor.lightGray
            ]
        }
    } // End func
    
    
    func xRotationAnimate() {
        if self.xRotation < 0 {
            self.xGradientLayer.colors = [
                UIColor(red: 89/255, green: 148/255, blue: 116/255, alpha: 1).cgColor,
                UIColor(red: 236/255, green: 177/255, blue: 135/255, alpha: 1).cgColor
            ]
        } else if self.xRotation > 0 {
            self.xGradientLayer.colors = [
                UIColor(red: 236/255, green: 177/255, blue: 135/255, alpha: 1).cgColor,
                UIColor(red: 89/255, green: 148/255, blue: 116/255, alpha: 1).cgColor
            ]
        } else {
            self.xGradientLayer.colors = [
                UIColor.clear,
                UIColor.clear
            ]
        }
    } // End func
    
    
} // End class


