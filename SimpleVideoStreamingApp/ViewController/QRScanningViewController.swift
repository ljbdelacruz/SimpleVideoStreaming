//
//  QRScanningViewController.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 13/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import AVFoundation


class QRScanningViewController: GeneralFuncViewController {

    
    
    @IBOutlet weak var UIDisplayScanner: UIView!
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    var url:URL?;
    var isSuccessScan:Bool=false;
    
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
        } catch {
            print(error)
            return
        }
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
//        view.layer.addSublayer(videoPreviewLayer!)
        UIDisplayScanner.layer.addSublayer(videoPreviewLayer!);
        view.addSubview(UIDisplayScanner);
        // Start video capture.
        captureSession.startRunning()
    }
    func CheckURL(url:String){
        self.url=nil;
        if url.contains("https") && !self.isSuccessScan{
            self.url=URLGetter.toURL(url: url);
            performSegue(withIdentifier: "scannerToVideoPlayer", sender: nil);
            self.isSuccessScan=true;
        }else if !self.isSuccessScan{
            ShowAlertMessage(title: "Error not URL", message: url);
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scannerToVideoPlayer"{
            let destVC=segue.destination as! URLVideoViewController;
            destVC.url=self.url;
        }
    }

}
//QR Scanning Func
extension QRScanningViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            if !self.isSuccessScan{
                ShowAlertMessage(title: "Error not URL", message: "No QR code is detected");
            }
            return
        }
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
        qrCodeFrameView?.frame = barCodeObject!.bounds
        if metadataObj.stringValue != nil {
            self.CheckURL(url: metadataObj.stringValue!);
        }
    }
}
