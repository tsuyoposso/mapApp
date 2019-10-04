//
//  ViewController.swift
//  mapAndProtocol
//
//  Created by 長坂豪士 on 2019/10/02.
//  Copyright © 2019 Tsuyoshi Nagasaka. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, SearchLocationDelegate {

    
    
    var addressString = ""
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var locManager:CLLocationManager!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingButton.backgroundColor = .white
        settingButton.layer.cornerRadius = 20.0
    }

    
    // senderにはlongtapの状態が入る
    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        
        // タップを開始したとき
        if sender.state == .began {
            
        } else if sender.state == .ended {
            // タップを終了
            // タップした位置を指定して、MKMapView上の緯度経度を取得する
            // 緯度経度から住所に変換する
            
            
            let tapPoint = sender.location(in: view)
            
            // タップした位置(CGPoint)を指定してMKMapView上の緯度経度を取得する
            // mapViewの上で指定したtapPointをcenterとして、緯度経度を取得する
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            let lat = center.latitude
            let log = center.longitude
            
            // convert関数を呼び出して処理を実行する
            convert(lat: lat, log: log)
            
        }
        
        
    }
    
    //
    func convert(lat:CLLocationDegrees, log:CLLocationDegrees) {
        
        // mapを使うときはこれを書くよ
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        
        
        // クロージャー
        // placeMarkかerrorに値が入ってきたときに動く
        // クロージャー内のメンバー変数にはselfをつける
        geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
            
            // オプショナルバインディング
            if let placeMark = placeMark {
                
                if let pm = placeMark.first {
                    // administrativeArea -> ex.東京都
                    // locality -> ex.区とか市とか
                    if pm.administrativeArea != nil || pm.locality != nil {
                       
                        self.addressString = pm.name! + pm.administrativeArea! + pm.locality!
                    } else {
                        
                        self.addressString = pm.name!
                    }
                    
                    self.addressLabel.text = self.addressString
                }
            }
            
            
            
            
        }
    }
    
    
    @IBAction func goToSearchVC(_ sender: Any) {
        
        //画面遷移
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "next" {
            
            let nextVC = segue.destination as! nextViewController
            
            // 
        }
    }
    
    func searchLocation(idoValue: String, keidoValue: String) {
        
        if idoValue.isEmpty != true && keidoValue.isEmpty != true {
            
            let idoString = idoValue
            let keidoString = keidoValue
            
            // 緯度、経度からコーディネート
            let coordinate = CLLocationCoordinate2DMake(Double(idoString)!, Double(keidoString)!)
            
            // 表示する範囲を指定する
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            
            // 領域を指定
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            // 領域をmapViewに設定
            mapView.setRegion(region, animated: true)
            
            // ラベルに表示
            addressLabel.text = addressString
            
        } else {
            
            addressLabel.text = "表示できません"
        }
        
    }

}

