//
//  LocationManager.swift
//  EOPPad
//
//  Created by mwk_pro on 2018/8/17.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import UIKit
import CoreLocation

public typealias MWLocationCompletion = (_ privince: String, _ city: String, _ zone: String)->Void


public class MWLocationManager: NSObject, CLLocationManagerDelegate {
    var manager : CLLocationManager!
    private var locationCompletion : MWLocationCompletion?
    static let shared = MWLocationManager()

    @objc public static func shareInstance() -> MWLocationManager {
        return MWLocationManager.shared
    }
    
    override init() {
        super.init()
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 100.0

    }
    
    public func startLocation( completion: @escaping MWLocationCompletion) {
        self.locationCompletion = completion

        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    //MARK:--CLLocationManagerDelegate
    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let newLocation = locations.last {
            let geo = CLGeocoder()
            geo.reverseGeocodeLocation(newLocation) { (placemarks, error) in
                if error == nil, let firstPlaceMark = placemarks!.first {
                    
                    //                NSLog(@"name,%@",place.name);                      // 位置名
                    //                NSLog(@"thoroughfare,%@",place.thoroughfare);      // 街道
                    //                NSLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
                    //                NSLog(@"locality,%@",place.locality);              // 市
                    //                NSLog(@"subLocality,%@",place.subLocality);        // 区
                    //                NSLog(@"country,%@",place.country);                // 国家
                    //                NSLog(@"administrativeArea,%@",place.administrativeArea);                // 省份
                    if let locality = firstPlaceMark.locality, let subLocality = firstPlaceMark.subLocality {
                        self.locationCompletion?(firstPlaceMark.administrativeArea ?? locality, locality, subLocality)
                        //只回调一次 
                        self.locationCompletion = nil
                    }
                }
            }
        }
    }
    
    private func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
}
