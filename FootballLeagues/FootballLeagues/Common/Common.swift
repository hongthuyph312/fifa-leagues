//
//  Common.swift
//  japanese
//
//  Created by Hai Dang Nguyen on 10/11/17.
//  Copyright © 2017 Beacon. All rights reserved.
//

import UIKit
import Photos

class Common: NSObject {

    // MARK: - COLOR
    // Custom color
    static func color(withRGB RGB: UInt) -> UIColor {
        return UIColor(red: CGFloat((RGB & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((RGB & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(RGB & 0x0000FF) / 255.0,
                       alpha: 1.0)
    }
    
    static func color(withRGB RGB: UInt, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat((RGB & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((RGB & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(RGB & 0x0000FF) / 255.0,
                       alpha: alpha)
    }
    
    // Show main color
    static func mainColor() -> UIColor {
        return self.color(withRGB: 0x47AC66)
    }
    
    // MARK: - DATE
    
    static func localToUTC(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "H:mm:ss"
        
        return dateFormatter.string(from: dt!)
    }
    
    static func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let localDate = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateFormatter.string(from: localDate!)
    }
    
    static func timeIntervalFromDateString(date:String) -> Double{
        // COnvert from string to Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = NSLocale.system
        let date = dateFormatter.date(from:date)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let finalDate = calendar.date(from:components)
        
        // Return to timeInterval
        return (finalDate?.timeIntervalSince1970)!
    }
    
    // Convert from Date to String of timeInterval
    static func stringFromDate(date:Date, format: String) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        formatter.locale = NSLocale.system
        return formatter.string(from: date)
    }
    
    // Convert from timeInterval to String with format
    static func stringFromTimeInterval(timeInterval: Double, format: String) -> String {
        //Return when timeInterval wrong
        if timeInterval <= 0 {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale.system
        formatter.dateFormat = format
        
        //Get Date from timeInterval
        let date = Date(timeIntervalSince1970: timeInterval)
        
        return formatter.string(from: date)
    }
    
    // MARK: - Appstore
    // Get local app version
    static func getAppVersion() -> String {
        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return text
        }
        
        return ""
    }
    
    static func getAppStoreLink(_ appId: String) -> String {
        var storeId = appId
        if !storeId.hasPrefix("id") {
            storeId = "id".appending(storeId)
        }
        
        return "itms-apps://itunes.apple.com/app/\(storeId)"
    }
    
    // MARK: - Function
    static func getVisibleViewController() -> OriginalViewController? {
        if let navRoot = app_delegate.window?.rootViewController {
            if navRoot.isKind(of: UINavigationController().classForCoder){
                let nav = navRoot as! UINavigationController
                return ((nav.viewControllers.last)! as? OriginalViewController)!
            } else {
                return nil
            }
        }
        return nil
    }
    
    static func isiPhoneX() -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && UIScreen.main.nativeBounds.size.height == 2436 {
            //Detect iPhoneX from resolution: 1125x2436
            return true
        }
        return false
    }
    
    // MARK: - CAMERA
    class func openCamera(controller: UIViewController) {
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied {
            let alertController = UIAlertController(title: "Ứng dụng này muốn truy cập máy ảnh", message: "Vui lòng cho phép để truy cập máy ảnh", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Mở cài đặt", style: .cancel) { alertController in
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
            controller.present(alertController, animated: true, completion: nil)
        } else {
            let picker = UIImagePickerController()
            picker.delegate = controller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.sourceType = UIImagePickerControllerSourceType.camera
            controller.present(picker, animated: true, completion: nil)
        }
    }
    
    class func openGallary(controller: UIViewController) {
        let picker = UIImagePickerController()
        picker.delegate = controller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate

        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.denied {
            let alertController = UIAlertController(title: "Ứng dụng này muốn truy cập thư viện ảnh", message: "Vui lòng cho phép để truy cập thư viện ảnh", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Mở cài đặt", style: .cancel) { alertController in
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
            controller.present(alertController, animated: true, completion: nil)
        } else if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == PHAuthorizationStatus.authorized {
                    picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                    controller.present(picker, animated: true, completion: nil)
                }
            })
        } else {
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            controller.present(picker, animated: true, completion: nil)
        }
    }
    
    class func resizeImage(image: UIImage, maxSize: CGFloat) -> UIImage {
        let size = image.size
        var newHeight: CGFloat!
        var newWidth: CGFloat!
        var scale: CGFloat!
        
        if size.width < maxSize || size.height < maxSize {
            return image
        } else {
            if size.width > size.height {
                newWidth = maxSize
                scale = newWidth / size.width
                newHeight = size.height * scale
                
            } else {
                newHeight = maxSize
                scale = newHeight / size.height
                newWidth = size.width * scale
            }
        }
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    class func getTopController() -> UIViewController {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            return vc
        }
        return UIViewController()
    }
    
    // MARK: - Local notification
    static func createNotification(match: ResultModel, isRepeat: Bool) -> UILocalNotification? {
        let team1 = app_delegate.clubArray.filter{$0.id == match.team1Id}.first
        let team2 = app_delegate.clubArray.filter{$0.id == match.team2Id}.first
        
        let message = "Match between \(String(describing: team1?.name)) and \(String(describing: team2?.name)) at \(Common.stringFromTimeInterval(timeInterval: match.time, format: "dd-MM-yyyy"))"
        let notification = UILocalNotification()
        notification.fireDate = Date.init(timeIntervalSinceNow: 10) //Date.init(timeIntervalSince1970: match.time)
        notification.alertBody = message
        notification.category = "schedule of match"
        notification.userInfo = ["matchId": match.time, "auto_created": isRepeat] as [String:Any]
        notification.soundName = UILocalNotificationDefaultSoundName
        return notification
    }
}
