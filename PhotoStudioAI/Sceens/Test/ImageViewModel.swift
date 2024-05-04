//
//  ImageViewModel.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 4.04.2024.
//

import Foundation

import CoreML
import SwiftUI
import Vision

class ImageViewModel: ObservableObject {
    @Published var inputImage: UIImage? = nil
    @Published var outputImage: UIImage? = nil

    func processImage() {
        guard let inputImage = inputImage else { return }
        
        // Convert UIImage to CIImage
        guard let ciInput = CIImage(image: inputImage) else { return }
        
        // Load the ML model
        guard let model = try? VNCoreMLModel(for: RMBG(configuration: MLModelConfiguration()).model) else {
            print("Failed to load the model")
            return
        }
        
        // Create a request for CoreML
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNPixelBufferObservation],
                  let pixelBuffer = results.first?.pixelBuffer else {
                print("Model failed to process image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Convert pixel buffer back to UIImage
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return }
            //self?.outputImage = UIImage(cgImage: cgImage)
            
            self?.applyMaskToImage(outputImage: UIImage(cgImage: cgImage))
        }
        
        // Perform the request on the input image
        let handler = VNImageRequestHandler(ciImage: ciInput, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    
    func applyMaskToImage(outputImage: UIImage) {
        guard let inputImage = inputImage else { return }
        
        // Convert UIImage to CIImage
        guard let ciInput = CIImage(image: inputImage), let ciMask = CIImage(image: outputImage) else { return }
        
        // Apply mask to the input image
        let maskedImage = ciInput.applyingFilter("CIBlendWithMask", parameters: ["inputMaskImage": ciMask])
        
        // Convert CIImage back to UIImage
        let context = CIContext()
        if let cgImage = context.createCGImage(maskedImage, from: maskedImage.extent) {
            self.outputImage = UIImage(cgImage: cgImage)
        }
    }
}

