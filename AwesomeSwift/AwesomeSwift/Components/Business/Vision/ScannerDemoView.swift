//
//  ScannerDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/30.
//

import SwiftUI
import VisionKit

@available(iOS 16.0, *)
struct ScannerDemoView: View {
    
    @State private var startScanning = false
    @State private var scanText = ""
    @State private var scannerTip = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text(scannerTip).foregroundColor(.gray).font(.system(size: 12))
                DataScanner(startScanning: $startScanning, scanText: $scanText)
                    .frame(height: 400)
                Text(scanText)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                    .background(in: Rectangle())
                    .backgroundStyle(Color(uiColor: .systemGray6))
            }
            .task {
                if DataScannerViewController.isSupported {
                    if DataScannerViewController.isAvailable {
                        startScanning.toggle()
                    } else {
                        self.scannerTip = "Scanner Not Available"
                    }
                } else {
                    self.scannerTip = "Scanner Not Support"
                }
            }
        }.navigationBarTitle("Scanner Demo View")
            .navigationBarTitleDisplayMode(.inline)
    }
}
