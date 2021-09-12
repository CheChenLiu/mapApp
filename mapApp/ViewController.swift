//
//  ViewController.swift
//  mapApp
//
//  Created by CheChenLiu on 2021/9/11.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ddLatitudeTextField: UITextField!
    @IBOutlet weak var ddLongitudeTextField: UITextField!
    
    @IBOutlet weak var dmmLatitudeFrontTextField: UITextField!
    @IBOutlet weak var dmmLatitudeBottomTextField: UITextField!
    @IBOutlet weak var dmmLongitudeFrontTextField: UITextField!
    @IBOutlet weak var dmmLongitudeBottomTextField: UITextField!
    
    @IBOutlet weak var dmsLatitudeFrontTextField: UITextField!
    @IBOutlet weak var dmsLatitudeMiddleTextField: UITextField!
    @IBOutlet weak var dmsLatitudeBottomTextField: UITextField!
    @IBOutlet weak var dmsLongitudeFrontTextField: UITextField!
    @IBOutlet weak var dmsLongitudeMiddleTextField: UITextField!
    @IBOutlet weak var dmsLongitudeBottomTextField: UITextField!
    
    @IBOutlet weak var mapAnnotationTextfield: UITextField!
    @IBOutlet weak var mapMKMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapMKMapView.mapType = .satellite
    }

    @IBAction func convertDD(_ sender: UIButton) {
        
        if let ddLatitude = ddLatitudeTextField.text,
           let ddLongitude = ddLongitudeTextField.text,
           let floatDDLatitude = Float(ddLatitude),
           let floatDDLongitude = Float(ddLongitude)
        {
            
            //取出整數
            let intDDLatitude = Int(floatDDLatitude)
            let intDDLongitude = Int(floatDDLongitude)
            
            print("intDDLatitude = \(intDDLatitude)", "intDDLongitude = \(intDDLongitude)")
            
            dmmLatitudeFrontTextField.text = "\(intDDLatitude)"
            dmmLongitudeFrontTextField.text = "\(intDDLongitude)"
            dmsLatitudeFrontTextField.text = "\(intDDLatitude)"
            dmsLongitudeFrontTextField.text = "\(intDDLongitude)"
            
            //取小數點乘60取分
            let ddLatitude = (floatDDLatitude - Float(intDDLatitude)) * 60
            let ddLongitude = (floatDDLongitude - Float(intDDLongitude)) * 60
            
            print("ddLatitude = \(ddLatitude)", "ddLongitude = \(ddLongitude)")
            
            dmmLatitudeBottomTextField.text = String(format: "%.4f", ddLatitude)
            dmmLongitudeBottomTextField.text = String(format: "%.4f", ddLongitude)
            dmsLatitudeMiddleTextField.text = String(format: "%.0f", ddLatitude)
            dmsLongitudeMiddleTextField.text = String(format: "%.0f", ddLongitude)
            
            //再取出目前分的整數
            let ddLatitude2 = Int(ddLatitude)
            let ddLongitude2 = Int(ddLongitude)
            
            print("ddLatitude2 = \(ddLatitude2)", "ddLongitude2 = \(ddLongitude2)")
            
            //取秒
            let ddLatitude3 = (ddLatitude - Float(ddLatitude2)) * 60
            let ddLongitude3 = (ddLongitude - Float(ddLongitude2)) * 60
            
            print("ddLatitude3 = \(ddLatitude3)", "ddLongitude3 = \(ddLongitude3)")
            
            dmsLatitudeBottomTextField.text = String(format: "%.2f", ddLatitude3)
            dmsLongitudeBottomTextField.text = String(format: "%.2f", ddLongitude3)
            
            let mapLatitude = Double(floatDDLatitude)
            let mapLongitude = Double(floatDDLongitude)
                
            mapMKMapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: mapLatitude, longitude: mapLongitude), latitudinalMeters: 1000, longitudinalMeters: 1000)
    
        } else {
            
            latitudeAndLongitudeNoTextAlert()
            
        }
        
        view.endEditing(true)
        
    }
    
    @IBAction func convertDMM(_ sender: UIButton) {
        
        if let dmmFrontLatitude = dmmLatitudeFrontTextField.text,
            let dmmBottomLatitude = dmmLatitudeBottomTextField.text,
            let dmmFrontLongitude = dmmLongitudeFrontTextField.text,
            let dmmBottomLongitude = dmmLongitudeBottomTextField.text,
            let intDmmFrontLatitude = Int(dmmFrontLatitude),
            let intDmmFrontLongitude = Int(dmmFrontLongitude),
            let floatDmmBottomLatitude = Float(dmmBottomLatitude),
            let floatDmmBottomLongitude = Float(dmmBottomLongitude)
        {
                
            dmsLatitudeFrontTextField.text = "\(intDmmFrontLatitude)"
            dmsLongitudeFrontTextField.text = "\(intDmmFrontLongitude)"
            
            //取整數經緯分顯示到dms
            let intDmmBottomLatitude = Int(floatDmmBottomLatitude)
            let intDmmBottomLongitude = Int(floatDmmBottomLongitude)
            
            print("intDmmBottomLatitude = \(intDmmBottomLatitude)", "intDmmBottomLongitude = \(intDmmBottomLongitude)")
            
            dmsLatitudeMiddleTextField.text = "\(intDmmBottomLatitude)"
            dmsLongitudeMiddleTextField.text = "\(intDmmBottomLongitude)"
            
            //把DMM經緯分除60再跟DMM經緯度相加得出DD經緯度
            let dmmLatitude = Float(intDmmFrontLatitude) + floatDmmBottomLatitude / 60
            let dmmLongitude = Float(intDmmFrontLongitude) + floatDmmBottomLongitude / 60
            
            print("dmmLatitude = \(dmmLatitude)", "dmmLongitude = \(dmmLongitude)")
            
            ddLatitudeTextField.text = "\(dmmLatitude)"
            ddLongitudeTextField.text = "\(dmmLongitude)"
            
            //把DMM經緯分乘60得出經緯秒
            let dmmLatitude2 = (floatDmmBottomLatitude - Float(intDmmBottomLatitude)) * 60
            let dmmLongitude2 = (floatDmmBottomLongitude - Float(intDmmBottomLongitude)) * 60
            
            print("dmmLatitude2 = \(dmmLatitude2)", "dmmLongitude2 = \(dmmLongitude2)")
            
            dmsLatitudeBottomTextField.text = String(format: "%.2f", dmmLatitude2)
            dmsLongitudeBottomTextField.text = String(format: "%.2f", dmmLongitude2)
            
            let mapLatitude = Double(dmmLatitude)
            let mapLongitude = Double(dmmLongitude)
            
            mapMKMapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: mapLatitude, longitude: mapLongitude), latitudinalMeters: 1000, longitudinalMeters: 1000)
            
        } else {
            
            latitudeAndLongitudeNoTextAlert()
            
        }
        
        view.endEditing(true)
        
    }
    
    @IBAction func convertDMS(_ sender: UIButton) {
        
        if let dmsLatitudeFront = dmsLatitudeFrontTextField.text,
            let dmsLatitudeMiddle = dmsLatitudeMiddleTextField.text,
            let dmsLatitudeBottom = dmsLatitudeBottomTextField.text,
            let dmsLongitudeFront = dmsLongitudeFrontTextField.text,
            let dmsLongitudeMiddle = dmsLongitudeMiddleTextField.text,
            let dmsLongitudeBottm = dmsLongitudeBottomTextField.text,
            let intDmsLatitudeFront = Int(dmsLatitudeFront),
            let intDmsLatitudeMiddle = Int(dmsLatitudeMiddle),
            let intDmsLongitudeFront = Int(dmsLongitudeFront),
            let intDmsLongitudeMiddle = Int(dmsLongitudeMiddle),
            let floatDmsLatitudeBottom = Float(dmsLatitudeBottom),
            let floatDmsLongitudeBottm = Float(dmsLongitudeBottm)
        {

            dmmLatitudeFrontTextField.text = "\(intDmsLatitudeFront)"
            dmmLongitudeFrontTextField.text = "\(intDmsLongitudeFront)"
            
            //把dms經緯秒除以60加上dms經緯分得到dmm經緯分
            let dmsLatitude = Float(intDmsLatitudeMiddle) + floatDmsLatitudeBottom / 60
            let dmsLongituge = Float(intDmsLongitudeMiddle) + floatDmsLongitudeBottm / 60
            
            print("dmsLatitude = \(dmsLatitude)", "dmsLongituge = \(dmsLongituge)")
            
            dmmLatitudeBottomTextField.text = String(format: "%.4f", dmsLatitude)
            dmmLongitudeBottomTextField.text = String(format: "%.4f", dmsLongituge)
            
            //把dms經緯秒相加後的值再除以3600加上dms經緯分除以60再加上dms經緯度得到dd經緯度
            let dmsLatitude2 = Float(intDmsLatitudeFront) + Float(intDmsLatitudeMiddle) / 60 + floatDmsLatitudeBottom / 3600
            let dmsLongitude2 = Float(intDmsLongitudeFront) + Float(intDmsLongitudeMiddle) / 60 + floatDmsLongitudeBottm / 3600
            
            print("dmsLatitude2 = \(dmsLatitude2)", "dmsLongitude2 = \(dmsLongitude2)")
            
            ddLatitudeTextField.text = "\(dmsLatitude2)"
            ddLongitudeTextField.text = "\(dmsLongitude2)"
            
            let mapLatitude = Double(dmsLatitude2)
            let mapLongitude = Double(dmsLongitude2)
            
            mapMKMapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: mapLatitude, longitude: mapLongitude), latitudinalMeters: 1000, longitudinalMeters: 1000)
                
        } else {
            
            latitudeAndLongitudeNoTextAlert()
            
        }
    
        view.endEditing(true)

    }
    
    private func latitudeAndLongitudeNoTextAlert() {
        
        let alertController = UIAlertController(title: "資料不完全", message: "請輸入需轉換的經緯度！", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func mapAnnotation(_ sender: UIButton) {
        
        if let ddLatitude = ddLatitudeTextField.text,
           let ddLongitude = ddLongitudeTextField.text,
            let mapLatitde = Double(ddLatitude),
            let mapLongitude = Double(ddLongitude)
        {
            
            mapMKMapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: mapLatitde, longitude: mapLongitude), latitudinalMeters: 1000, longitudinalMeters: 1000)
            
            let annotation = mapAnnotationTextfield.text!
            //利用 MKPointAnnotation 產生地圖標記
            let mapAnnotation = MKPointAnnotation()
            
            mapAnnotation.title = "\(annotation)"
            //透過它的 coordinate 設定經緯度座標
            mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: mapLatitde, longitude: mapLongitude)
            //加入mapMKMapView
            mapMKMapView.addAnnotation(mapAnnotation)
        } else {
            
            mapAlert()
            
        }
        
        view.endEditing(true)
        
    }
    
    private func mapAlert() {
        
        let alertController = UIAlertController(title: "地點名未輸入", message: "請輸入想標記的地點名稱！", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }

    @IBAction func tapViewToCloseKeyBoard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func pressReturnToCloseKeyBoard(_ sender: UITextField) {
    }
    
    @IBAction func clearAllTextField(_ sender: UIButton) {
        
        ddLatitudeTextField.text = ""
        ddLongitudeTextField.text = ""
        
        dmmLatitudeFrontTextField.text = ""
        dmmLatitudeBottomTextField.text = ""
        dmmLongitudeFrontTextField.text = ""
        dmmLongitudeBottomTextField.text = ""
        
        dmsLatitudeFrontTextField.text = ""
        dmsLatitudeMiddleTextField.text = ""
        dmsLatitudeBottomTextField.text = ""
        dmsLongitudeFrontTextField.text = ""
        dmsLongitudeMiddleTextField.text = ""
        dmsLongitudeBottomTextField.text = ""
        
        mapAnnotationTextfield.text = ""
        
        //地圖回到台灣全景
        mapMKMapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.535267, longitude: 120.961449), latitudinalMeters: 400000, longitudinalMeters: 400000)
        
    }
    
}

