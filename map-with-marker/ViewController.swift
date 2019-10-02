/*
 * Copyright 2016 Google Inc. All rights reserved.
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
 * file except in compliance with the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
 * ANY KIND, either express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import UIKit
import Photos
import Kingfisher
import GoogleMaps
import Foundation

class ViewController: UIViewController {
    var mapView: GMSMapView!
    
    override func loadView() {
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude:21.0165532, longitude: 105.7977057, zoom: 17.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        /*let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 21.0165532, longitude: 105.7977057)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView*/
        
        //createMarkerFromUrl(urlString: "https://we25.vn/media/images/o-anhvong3%20(4).jpg")//Good
        
        addMarkerFromUrl(urlString: "https://we25.vn/media/images/o-anhvong3%20(4).jpg")
        addMarkerFromUrl("https://we25.vn/media/images/o-anhvong3%20(4).jpg", "https://storage.oxii.vn/thumbnail/OXII-957-2019-2-26/ke-ni-nang-hotgirl-lanh-lung-khong-bao-gio-nhoen-mieng-cuoi-anh-2.jpg")
    }
    
    func addMarkerFromUrl(urlString: String) {
        
        let customMarker = CustomMarker.instancefromNib() as! CustomMarker
        customMarker.fillData("6", urlString)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 21.014381, longitude: 105.796763)
        marker.title = "Kingfisher"
        marker.snippet = "Loading Image"
        marker.iconView = customMarker
        marker.map = self.mapView
    }
    
    func addMarkerFromUrl(_ urlString: String, _ urlString2: String) {
        
        let customMarker = CustomMarker.instancefromNib() as! CustomMarker
        customMarker.roundedAndShadow()
        customMarker.fillDataWith("9", urlString, urlString2)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 21.0165532, longitude: 105.7977057)
        marker.title = "AlamofireImage"
        marker.snippet = "Loading Image"
        marker.iconView = customMarker
        marker.map = self.mapView
        
    }
    
    func createMarkerFromUrl(urlString: String) {
    
        guard let urlRes = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: urlRes)
        //var imgMarker = UIImage()
        //let processor = ResizingImageProcessor(referenceSize: CGSize(width: 60.0, height: 60.0)) >> RoundCornerImageProcessor(cornerRadius: 4.0)
        let processor = CroppingImageProcessor(size: CGSize(width: 100.0, height: 100.0), anchor: CGPoint(x: 0.5, y: 0.5)) >> RoundCornerImageProcessor(cornerRadius: 4.0)

        KingfisherManager.shared.retrieveImage(with: resource, options: [.processor(processor)], progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
            //print(image)
            if error == nil {
                //add marker icon
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: 21.0165532, longitude: 105.7977057)
                marker.title = "Ha Noi"
                marker.snippet = "Vietnam"
                
                let width = 60.0
                let height = 60.0
                
                //Resize solution
                //marker.icon = image?.resizeImage(width)
                
                let size = CGSize(width: width, height: height)
                //marker.icon = image?.crop(to: size)*/
                
                let customMarker = CustomMarker.instancefromNib() as! CustomMarker
                
                //customMarker.fillData(nil, image!)
                /*let img = image?.crop(to: size)
                customMarker.fillData("9", img!)*/
                
                customMarker.fillData("9", image)
                
                marker.iconView = customMarker
                marker.map = self.mapView
            }
            else {}
        })
    }

}

extension UIImage {
    
    func cropToBounds(width: Double, height: Double) -> UIImage {
        
        let cgimage = cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
        
        return image
    }
    
    func crop(to:CGSize) -> UIImage {
        
        guard let cgimage = self.cgImage else { return self }
        
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        
        guard let newCgImage = contextImage.cgImage else { return self }
        
        let contextSize: CGSize = contextImage.size
        
        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height
        
        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height
        
        if to.width > to.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if to.width < to.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height { //Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)
        
        // Create bitmap image from context using the rect
        guard let imageRef: CGImage = newCgImage.cropping(to: rect) else { return self}
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        UIGraphicsBeginImageContextWithOptions(to, false, self.scale)
        cropped.draw(in: CGRect(x: 0, y: 0, width: to.width, height: to.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resized ?? self
    }
    
    func crop(rect: CGRect) -> UIImage {
        
        var rectTransform: CGAffineTransform
        switch imageOrientation {
        case .left:
            rectTransform = CGAffineTransform(rotationAngle: radians(90)).translatedBy(x: 0, y: -size.height)
        case .right:
            rectTransform = CGAffineTransform(rotationAngle: radians(-90)).translatedBy(x: -size.width, y: 0)
        case .down:
            rectTransform = CGAffineTransform(rotationAngle: radians(-180)).translatedBy(x: -size.width, y: -size.height)
        default:
            rectTransform = CGAffineTransform.identity
        }
        
        rectTransform = rectTransform.scaledBy(x: scale, y: scale)
        
        if let cropped = cgImage?.cropping(to: rect.applying(rectTransform)) {
            return UIImage(cgImage: cropped, scale: scale, orientation: imageOrientation).fixOrientation()
        }
        
        return self
    }
    
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImageOrientation.up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x:0, y:0,width: self.size.width, height:self.size.height))
        let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage;
    }
    
    func resizeImage(_ width:CGFloat) -> UIImage {
        let takenCGImage : CGImage = self.cgImage!
        let originWidth : Int = takenCGImage.width;
        let originHeight : Int = takenCGImage.height;
        let resizeWidth:Int = Int(width)
        let resizeSize: CGSize!
        if originWidth <= resizeWidth {
            resizeSize = CGSize.init(width: CGFloat(originWidth), height: CGFloat(originHeight))
        }
        else {
            let resizeHeight = originHeight * resizeWidth / originWidth
            resizeSize = CGSize.init(width: CGFloat(resizeWidth), height: CGFloat(resizeHeight))
        }
        UIGraphicsBeginImageContext(resizeSize)
        self.draw(in: CGRect(x: 0, y: 0, width: CGFloat(resizeSize.width), height: CGFloat(resizeSize.height)))
        let resizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizeImage
        
    }
    
    func resize(to newSize: CGSize) -> UIImage? {
        
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        defer { UIGraphicsEndImageContext() }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    fileprivate func resizeImage(_ image :UIImage, w:CGFloat) -> UIImage {
        
        let takenCGImage : CGImage = image.cgImage!
        let origWidth : Int = takenCGImage.width;
        let origHeight : Int = takenCGImage.height;
        var resizeWidth:Int = 0
        var resizeHeight:Int = 0
        
        resizeWidth = Int(w)
        resizeHeight = origHeight * resizeWidth / origWidth
        
        let resizeSize = CGSize.init(width: CGFloat(resizeWidth), height: CGFloat(resizeHeight))
        UIGraphicsBeginImageContext(resizeSize)
        
        image.draw(in: CGRect(x: 0, y: 0, width: CGFloat(resizeWidth), height: CGFloat(resizeHeight)))
        
        let resizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return resizeImage
    }
    
}
