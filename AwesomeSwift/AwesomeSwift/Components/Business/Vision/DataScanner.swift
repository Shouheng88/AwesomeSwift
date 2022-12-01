//
//  DataScanner.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/30.
//

import Foundation
import SwiftUI
import VisionKit

@available(iOS 16.0, *)
struct DataScanner: UIViewControllerRepresentable {

    @Binding var startScanning: Bool
    @Binding var scanText: String
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScanner
     
        init(_ parent: DataScanner) {
            self.parent = parent
        }
     
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .text(let text):
                parent.scanText = text.transcript
                print("text: \(text.transcript)")
            case .barcode(let barcode):
                print("barcode: \(barcode.payloadStringValue ?? "unknown")")
                break
            default: break
            }
        }
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.text(), .barcode(symbologies: [.qr, .ean13])],
            // 另一种指定方式，可以指定识别的语言
//            recognizedDataTypes: [.text(languages: ["en"]), .barcode(symbologies: [.qr, .ean13])],
            qualityLevel: .balanced,
            isHighlightingEnabled: true
        )
        controller.delegate = context.coordinator
        return controller
    }
     
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if startScanning {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
