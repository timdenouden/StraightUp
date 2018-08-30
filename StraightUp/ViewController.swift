//
//  ViewController.swift
//  StraightUp
//
//  Created by Timothy DenOuden on 4/2/17.
//  Copyright © 2017 Timothy DenOuden. All rights reserved.
//

import UIKit
import SpriteKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    @IBOutlet weak var skView: SKView!
    @IBOutlet weak var connectButton: UIBarButtonItem!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var slouchLabel: UILabel!
    @IBOutlet weak var uprightLabel: UILabel!
    
    var postureScene : TestScene?
    var centralManager: CBCentralManager!
    var sensor: CBPeripheral?
    var keepScanning = true
    var currentPosition = 0.0
    var maxSlouch = 100.0
    var minSlouch = 0.0
    
    @IBAction func connectButtonDidPress(_ sender: UIBarButtonItem) {
        if(centralManager != nil) {
            centralManager.stopScan()
            let uuid = CBUUID(string: "FFE0")
            centralManager.scanForPeripherals(withServices: [uuid], options: nil)
        }
        maxSlouch = 100.0
        minSlouch = 0.0
        uprightLabel.text = "Upright: " + String(minSlouch)
        slouchLabel.text = "Slouch: " + String(maxSlouch)
    }
    
    @IBAction func uprightDidPress(_ sender: Any) {
        minSlouch = currentPosition
        uprightLabel.text = "Upright: " + String(minSlouch)
    }
    
    @IBAction func slouchDidPress(_ sender: Any) {
        maxSlouch = currentPosition
        slouchLabel.text = "Slouch: " + String(maxSlouch)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView.ignoresSiblingOrder = false
        skView.allowsTransparency = true
        postureScene = TestScene(size: skView.bounds.size)
        skView.presentScene(postureScene)
        
        /*let noonColor = hexStringToUIColor(hex: "#ff6e7f")
        let duskColor = hexStringToUIColor(hex: "#bfe9ff")
        
        let graphView = ScrollableGraphView(frame: CGRect(x: 0, y: self.view.frame.width, width: self.view.frame.width, height: self.view.frame.height - self.view.frame.width))
        
        graphView.backgroundFillColor = .white
        
        graphView.rangeMax = 1
        
        graphView.lineWidth = 1
        graphView.lineColor = noonColor
        graphView.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        graphView.shouldFill = true
        graphView.fillType = ScrollableGraphViewFillType.gradient
        graphView.fillColor = noonColor
        graphView.fillGradientType = ScrollableGraphViewGradientType.linear
        graphView.fillGradientStartColor = duskColor
        graphView.fillGradientEndColor = noonColor
        
        graphView.dataPointSpacing = 80
        graphView.dataPointSize = 2
        graphView.dataPointFillColor = noonColor
        
        graphView.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        graphView.referenceLineColor = duskColor.withAlphaComponent(0.3)
        graphView.referenceLineLabelColor = duskColor
        graphView.dataPointLabelColor = duskColor.withAlphaComponent(0.5)
        
        graphView.set(data: postureScene!.data, withLabels: [])
        self.view.addSubview(graphView)*/
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK centralManagerDelegate
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("CentralManager is initialized")
        
        switch central.state{
        case .unauthorized:
            print("The app is not authorized to use Bluetooth low energy.")
        case .poweredOff:
            print("Bluetooth is currently powered off.")
        case .poweredOn:
            print("Bluetooth is currently powered on and available to use.")
            let uuid = CBUUID(string: "FFE0")
            centralManager.scanForPeripherals(withServices: [uuid], options: nil)
        default:break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("didDiscover")
        if let name = peripheral.name {
            print(name)
        }
        self.sensor = peripheral
        centralManager.connect(self.sensor!, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("did connect peripheral")
        peripheral.delegate = self
        let uuid = CBUUID(string: "FFE0")
        peripheral.discoverServices([uuid])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("did discover services")
        let uuid = CBUUID(string: "FFE1")
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics([uuid], for: service)
                print("put uuid in service")
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("did discover characteristics")
        for characteristic in service.characteristics! {
            print(characteristic)
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print("didUpadateNotificationState")
        print(characteristic)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let array = [UInt8](characteristic.value!)
        var stringRepresentation = ""
        for value in array {
            stringRepresentation = stringRepresentation + String(UnicodeScalar(value))
        }
        valueLabel.text = "Current Value: " + stringRepresentation;
        print(stringRepresentation);
        if let number = Double(stringRepresentation) {
            currentPosition = number
            let range = maxSlouch - minSlouch
            let delta = currentPosition - minSlouch
            postureScene?.slouch(by: CGFloat(delta / range))
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    @IBAction func didSliderChange(_ sender: UISlider) {
        let sliderValue = CGFloat(sender.value)
        postureScene?.slouch(by: sliderValue)
    }
    
    @IBAction func didPlayButtonPress(_ sender: UIButton) {
        postureScene?.reset()
        centralManager.stopScan()
    }
}

