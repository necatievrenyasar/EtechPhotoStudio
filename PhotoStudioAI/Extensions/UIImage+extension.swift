//
//  UIImage+extension.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 9.04.2024.
//

import Foundation
import UIKit

extension UIImage {
    
    func drawOutline(imageKeof: CGFloat = 0.2, color: UIColor = .white)-> UIImage? {
        let outlinedImageRect = CGRect(x: 0.0, y: 0.0, width: size.width * imageKeof, height: size.height * imageKeof)
        let imageRect = CGRect(x: self.size.width * (imageKeof - 1) * 0.5, y: self.size.height * (imageKeof - 1) * 0.5, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(outlinedImageRect.size, false, imageKeof)
        draw(in: outlinedImageRect)
        let context = UIGraphicsGetCurrentContext()
        context!.setBlendMode(.sourceIn)
        context!.setFillColor(color.cgColor)
        context!.fill(outlinedImageRect)
        draw(in: imageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
public extension UIImage {

    /**
    Returns the flat colorized version of the image, or self when something was wrong

    - Parameters:
        - color: The colors to user. By defaut, uses the ``UIColor.white`

    - Returns: the flat colorized version of the image, or the self if something was wrong
    */
    func colorized(with color: UIColor = .white) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }


        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        color.setFill()
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: rect, mask: cgImage)
        context.fill(rect)

        guard let colored = UIGraphicsGetImageFromCurrentImageContext() else { return self }

        return colored
    }

    /**
    Returns the stroked version of the fransparent image with the given stroke color and the thickness.

    - Parameters:
        - color: The colors to user. By defaut, uses the ``UIColor.white`
        - thickness: the thickness of the border. Default to `2`
        - quality: The number of degrees (out of 360): the smaller the best, but the slower. Defaults to `10`.

    - Returns: the stroked version of the image, or self if something was wrong
    */

    func stroked(with color: UIColor = .white, thickness: CGFloat = 2, quality: CGFloat = 100) -> UIImage {

        guard let cgImage = cgImage else { return self }

        // Colorize the stroke image to reflect border color
        let strokeImage = colorized(with: color)

        guard let strokeCGImage = strokeImage.cgImage else { return self }

        /// Rendering quality of the stroke
        let step = quality == 0 ? 10 : abs(quality)

        let oldRect = CGRect(x: thickness, y: thickness, width: size.width, height: size.height).integral
        let newSize = CGSize(width: size.width + 2 * thickness, height: size.height + 2 * thickness)
        let translationVector = CGPoint(x: thickness, y: 0)


        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)

        guard let context = UIGraphicsGetCurrentContext() else { return self }

        defer {
            UIGraphicsEndImageContext()
        }
        context.translateBy(x: 0, y: newSize.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.interpolationQuality = .high

        for angle: CGFloat in stride(from: 0, to: 360, by: step) {
            let vector = translationVector.rotated(around: .zero, byDegrees: angle)
            let transform = CGAffineTransform(translationX: vector.x, y: vector.y)

            context.concatenate(transform)

            context.draw(strokeCGImage, in: oldRect)

            let resetTransform = CGAffineTransform(translationX: -vector.x, y: -vector.y)
            context.concatenate(resetTransform)
        }

        context.draw(cgImage, in: oldRect)

        guard let stroked = UIGraphicsGetImageFromCurrentImageContext() else { return self }

        return stroked
    }
    
    
    
    func stroked3(with color: UIColor = .white, thickness: CGFloat = 2, quality: CGFloat = 100) -> UIImage {
        guard let cgImage = cgImage else { return self }

        // Colorize the stroke image to reflect border color
        let strokeImage = colorized(with: color)

        guard let strokeCGImage = strokeImage.cgImage else { return self }

        /// Rendering quality of the stroke
        let step = quality == 0 ? 10 : abs(quality)

        // Calculate new size to fit the stroke around the original image
        let newSize = CGSize(width: size.width +  thickness, height: size.height + thickness)
        let newRect = CGRect(x: 0, y: 0, width: size.width + thickness, height: size.height + thickness)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)

        guard let context = UIGraphicsGetCurrentContext() else { return self }

        defer {
            UIGraphicsEndImageContext()
        }

        context.translateBy(x: 0, y: newSize.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.interpolationQuality = .high

        // Draw the stroke around the image
        for angle in stride(from: 0, to: 360, by: step) {
            let radians:CGFloat = angle * CGFloat.pi / 180
            let vector = CGPoint(x: cos(radians) * thickness, y: sin(radians) * thickness)
            let transform = CGAffineTransform(translationX: vector.x, y: vector.y)

            context.saveGState()
            context.concatenate(transform)
            context.draw(strokeCGImage, in: newRect)
            context.restoreGState()
        }

        // Draw the original image
        context.draw(cgImage, in: newRect)

        guard let strokedImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }

        return strokedImage
    }
}


extension CGPoint {
    /**
    Rotates the point from the center `origin` by `byDegrees` degrees along the Z axis.

    - Parameters:
        - origin: The center of he rotation;
        - byDegrees: Amount of degrees to rotate around the Z axis.

    - Returns: The rotated point.
    */
    func rotated(around origin: CGPoint, byDegrees: CGFloat) -> CGPoint {
        let dx = x - origin.x
        let dy = y - origin.y
        let radius = sqrt(dx * dx + dy * dy)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + byDegrees * .pi / 180.0 // to radians
        let x = origin.x + radius * cos(newAzimuth)
        let y = origin.y + radius * sin(newAzimuth)
        return CGPoint(x: x, y: y)
    }
}
