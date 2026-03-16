//
//  CameraManager.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 3/8/26.
//

import AVFoundation
import UIKit
import Combine

class CameraManager: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    
    let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private var device: AVCaptureDevice?
    var onPhotoCaptured: ((UIImage) -> Void)?
    
    func start() {
        session.beginConfiguration()
        
        guard let camera = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: camera)
        else { return }
        
        device = camera
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
        session.commitConfiguration()
        session.startRunning()
    }
    
    func stop() {
        session.stopRunning()
    }
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    func setZoom(_ factor: CGFloat) {
        
        guard let device = device else { return }
        
        try? device.lockForConfiguration()
        device.videoZoomFactor = max(1.0, min(factor, device.activeFormat.videoMaxZoomFactor))
        device.unlockForConfiguration()
    }
    func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: Error?
    ) {
        
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data)
        else { return }
        
        DispatchQueue.main.async {
            self.onPhotoCaptured?(image)
        }
    }
}
