//
//  CustomMarker.swift
//  map-with-marker
//
//  Created by Robert on 9/27/19.
//  Copyright © 2019 William French. All rights reserved.
//
import UIKit
import Kingfisher

import Alamofire
import AlamofireImage

import Foundation

class CustomMarker: UIView {
    
    @IBOutlet weak var shopPhoto1: UIImageView!
    @IBOutlet weak var shopPhoto2: UIImageView!
    @IBOutlet weak var lblBadge: UILabel!
    
    /*override init(frame: CGRect) {
        super.init(frame: frame)
        self.instancefromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instancefromNib()
    }*/
    
    
    func instancefromNib() {
        let view = Bundle.main.loadNibNamed("CustomMarker", owner: self, options: nil)!.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        self.lblBadge.text = "9"
    }
    
    class func instancefromNib() -> UIView {
        return UINib.init(nibName: "CustomMarker", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func roundedAndShadow() {
        //Make border and corner
        self.shopPhoto1.makeRoundedWithBorder(radius: 4.0, borderWidth: 2.0, borderColor: UIColor.white)
        //Make shadow
        self.shopPhoto1.addShadow(offset: CGSize.init(width: 3, height: 3), shadowColor: UIColor.black, radius: 4.0, opacity: 0.35)
        
        //Make border and corner
        self.shopPhoto2.makeRoundedWithBorder(radius: 4.0, borderWidth: 2.0, borderColor: UIColor.white)
        //Make shadow
        self.shopPhoto2.addShadow(offset: CGSize.init(width: 3, height: 3), shadowColor: UIColor.black, radius: 4.0, opacity: 0.35)
        
    }
    
    func fillData(_ badgeNumber:String?, _ image: UIImage?) {
        guard let badge = badgeNumber else {
            self.lblBadge.isHidden = true
            return
        }
        //Set badge value
        self.lblBadge.text = badge
        //Make border and corner
        self.lblBadge.makeRoundedWithBorder(radius: self.lblBadge.bounds.size.width/2, borderWidth: 2.0, borderColor: UIColor.white)
        
        if image == nil {
            self.shopPhoto1.isHidden = true
            return
        }
        //Set image
        self.shopPhoto1.image = image
        //Make border and corner
        self.shopPhoto1.makeRoundedWithBorder(radius: 4.0, borderWidth: 2.0, borderColor: UIColor.white)
        //Make shadow
        self.shopPhoto1.addShadow(offset: CGSize.init(width: 3, height: 3), shadowColor: UIColor.black, radius: 4.0, opacity: 0.35)
    }
    
    func fillData(_ badgeNumber: String?, _ urlString: String) {
        guard let badge = badgeNumber else {
            self.lblBadge.isHidden = true
            return
        }
        //Set badge value
        self.lblBadge.text = badge
        //Make border and corner
        self.lblBadge.makeRoundedWithBorder(radius: self.lblBadge.bounds.size.width/2, borderWidth: 2.0, borderColor: UIColor.white)
        
        //Set image
        //let processor = ResizingImageProcessor(referenceSize: self.frame.size) >> RoundCornerImageProcessor(cornerRadius: 4.0)
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: 60.0, height: 60.0)) >> RoundCornerImageProcessor(cornerRadius: 4.0)
        self.shopPhoto1.kf.setImage(with: URL(string: urlString), placeholder: nil, options: [.processor(processor)])
        //Make border and corner
        self.shopPhoto1.makeRoundedWithBorder(radius: 4.0, borderWidth: 2.0, borderColor: UIColor.white)
        //Make shadow
        self.shopPhoto1.addShadow(offset: CGSize.init(width: 3, height: 3), shadowColor: UIColor.black, radius: 4.0, opacity: 0.35)
        
        
        let processor2 = ResizingImageProcessor(referenceSize: CGSize(width: 60.0, height: 60.0)) >> RoundCornerImageProcessor(cornerRadius: 4.0)
        self.shopPhoto2.kf.setImage(with: URL(string: urlString), placeholder: nil, options: [.processor(processor2), .transition(.fade(0.2)), .backgroundDecode], progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            print("Load image successful")
        })
        //Make border and corner
        self.shopPhoto2.makeRoundedWithBorder(radius: 4.0, borderWidth: 2.0, borderColor: UIColor.white)
        //Make shadow
        self.shopPhoto2.addShadow(offset: CGSize.init(width: 3, height: 3), shadowColor: UIColor.black, radius: 4.0, opacity: 0.35)
    }
    
    func fillData(_ badgeNumber: String?, _ urlString: String, _ urlString2: String) {
        guard let badge = badgeNumber else {
            self.lblBadge.isHidden = true
            return
        }
        //Set badge value
        self.lblBadge.text = badge
        //Make border and corner
        self.lblBadge.makeRoundedWithBorder(radius: self.lblBadge.bounds.size.width/2, borderWidth: 2.0, borderColor: UIColor.white)
        
        //Set image
        //let processor = ResizingImageProcessor(referenceSize: self.frame.size) >> RoundCornerImageProcessor(cornerRadius: 4.0)
        //let processor = ResizingImageProcessor(referenceSize: CGSize(width: 60.0, height: 60.0)) >> RoundCornerImageProcessor(cornerRadius: 4.0)
        let processor = CroppingImageProcessor(size: CGSize(width: 60.0, height: 60.0), anchor: CGPoint(x: 0.5, y: 0.5)) >> RoundCornerImageProcessor(cornerRadius: 4.0)
        //let processor = RoundCornerImageProcessor(cornerRadius: 4.0)
        //let processor = CenterCropImageProcessor(centerPoint: 100.0) >> RoundCornerImageProcessor(cornerRadius: 4.0)
        
        //self.shopPhoto1.kf.setImage(with: URL(string: urlString), placeholder: nil, options: [.processor(processor)])
        self.shopPhoto1.kf.setImage(with: URL(string: urlString), placeholder: nil, options: [.processor(processor), .transition(.fade(0.2)), .backgroundDecode], progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            print("Load image successful")
            //
            //let size = CGSize(width: 60.0, height: 60.0)
            //self.shopPhoto1.image = image?.crop(to: size)

        })

        //Set image 2
        //urlString2 = "http://192.168.10.10/abc.png"
        //self.shopPhoto2.kf.setImage(with: URL(string: urlString2), placeholder: nil, options: [.processor(processor)])
        /*self.shopPhoto2.kf.setImage(with: URL(string: urlString2), placeholder: nil, options: [.processor(processor), .transition(.fade(0.2)), .backgroundDecode], progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            print("Load image successful")
            //
            //let size = CGSize(width: 60.0, height: 60.0)
            //self.shopPhoto2.image = image?.crop(to: size)
            //self.shopPhoto2.image = image!.circularImage()
            //self.shopPhoto2.image = image?.crop(to: size).roundImage(100.0)
        })*/

        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: self.shopPhoto2.frame.size,
            radius: 4.0
        )
        
        guard let photo2 = self.shopPhoto2 else {
            
            return
        }
        
        photo2.af_setImage(
            withURL: URL(string:urlString2)!,
            placeholderImage: nil,
            filter: filter,
            imageTransition: .crossDissolve(0.2)
        )
    }

    func fillDataWith(_ badgeNumber: String?, _ urlString: String, _ urlString2: String) {
        guard let badge = badgeNumber else {
            self.lblBadge.isHidden = true
            return
        }
        //Set badge value
        self.lblBadge.text = badge
        //Make border and corner
        self.lblBadge.makeRoundedWithBorder(radius: self.lblBadge.bounds.size.width/2, borderWidth: 2.0, borderColor: UIColor.white)
        
        //Set image
        let filter1 = AspectScaledToFillSizeWithRoundedCornersFilter(size: self.shopPhoto1.frame.size, radius: 4.0)
        guard let photo1 = self.shopPhoto1 else {
            return
        }
        
        photo1.af_setImage(withURL: URL(string:urlString)!, placeholderImage: nil, filter: filter1, imageTransition: .crossDissolve(0.2))
        
        let filter2 = AspectScaledToFillSizeWithRoundedCornersFilter(size: self.shopPhoto2.frame.size, radius: 4.0)
        guard let photo2 = self.shopPhoto2 else {
            return
        }
        
        photo2.af_setImage(withURL: URL(string:urlString2)!, placeholderImage: nil, filter: filter2, imageTransition: .crossDissolve(0.2))
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
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
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
}
public struct CenterCropImageProcessor: ImageProcessor {
    public let identifier: String
    
    /// Center point to crop to.
    public var centerPoint: CGFloat = 0.0
    
    /// Initialize a `CenterCropImageProcessor`
    ///
    /// - parameter centerPoint: The center point to crop to.
    ///
    /// - returns: An initialized `CenterCropImageProcessor`.
    public init(centerPoint: CGFloat? = nil) {
        if let center = centerPoint {
            self.centerPoint = center
        }
        self.identifier = "com.l4grange.CenterCropImageProcessor(\(centerPoint))"
    }
    
    public func process(item: ImageProcessItem, options: KingfisherOptionsInfo) -> Image? {
        switch item {
        case .image(let image):
            
            var imageHeight = image.size.height
            var imageWidth = image.size.width
            
            if imageHeight > imageWidth {
                imageHeight = imageWidth
            }
            else {
                imageWidth = imageHeight
            }
            
            let size = CGSize(width: imageWidth, height: imageHeight)
            
            let refWidth : CGFloat = CGFloat(image.cgImage!.width)
            let refHeight : CGFloat = CGFloat(image.cgImage!.height)
            
            let x = (refWidth - size.width) / 2
            let y = (refHeight - size.height) / 2
            
            let cropRect = CGRect(x: x, y: y, width: size.height, height: size.width)
            if let imageRef = image.cgImage!.cropping(to: cropRect) {
                return UIImage(cgImage: imageRef, scale: 0, orientation: image.imageOrientation)
            }
            
            return nil
            
        case .data(_):
            return (DefaultImageProcessor.default >> self).process(item: item, options: options)
        }
    }
}

extension UIImage {
    
    func circularImage() -> UIImage {
        let newImage = self.copy() as! UIImage
        let cornerRadius = self.size.height/2
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1.0)
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.width)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        newImage.draw(in: bounds)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage!
    }
    
    func roundImage(_ radius: CGFloat) -> UIImage? {
        var imageView = UIImageView()
        if self.size.width > self.size.height {
            imageView.frame =  CGRect(x: 0, y: 0, width: self.size.width, height: self.size.width)
            imageView.image = self
            imageView.contentMode = .scaleAspectFit
        } else {
            imageView = UIImageView(image: self)
            
        }
        var layer: CALayer = CALayer()
        
        layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = radius
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage
    }
    
    func centerCrop(/*image: UIImage*/)-> UIImage? {
        let image = images![0]
        if image == nil {
            return nil
        }
        var imageHeight = image.size.height
        var imageWidth = image.size.width
        
        if imageHeight > imageWidth {
            imageHeight = imageWidth
        }
        else {
            imageWidth = imageHeight
        }
        
        let size = CGSize(width: imageWidth, height: imageHeight)
        
        let refWidth : CGFloat = CGFloat(image.cgImage!.width)
        let refHeight : CGFloat = CGFloat(image.cgImage!.height)
        
        let x = (refWidth - size.width) / 2
        let y = (refHeight - size.height) / 2
        
        let cropRect = CGRect(x: x, y: y, width: size.height, height: size.width)
        if let imageRef = image.cgImage!.cropping(to: cropRect) {
            return UIImage(cgImage: imageRef, scale: 0, orientation: image.imageOrientation)
        }
        
        return nil
    }
}

extension UIView {
    
    func makeRoundedWithBorder(radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    func addShadow(offset: CGSize, shadowColor: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowColor = shadowColor.cgColor
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
