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
            case .barcode(let barcode):
                break
            default: break
            }
        }
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.text()],
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
