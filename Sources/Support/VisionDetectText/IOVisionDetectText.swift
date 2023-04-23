//
//  IOVisionDetectText.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import Vision

struct IOVisionDetectText {
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates
    
    private let textRequest: VNRecognizeTextRequest
    
    // MARK: - Initialization Methods
    
    init(handler: @escaping (_ results: [[String]]) -> Void) {
        self.textRequest = VNRecognizeTextRequest { request, _ in
            guard let results = request.results as? [VNRecognizedTextObservation] else { return }
            let recognizedTexts = results.map { $0.topCandidates(10) }
            
            var resultsString = [[String]]()
            recognizedTexts.forEach { item in
                let itemStrings = item.map { $0.string }
                resultsString.append(itemStrings)
            }
            
            handler(resultsString)
        }
        self.textRequest.recognitionLevel = .accurate
        self.textRequest.recognitionLanguages = ["en_US"]
    }
    
    // MARK: - Text Detection Methods
    
    func detectText(buffer: CMSampleBuffer) {
        let handler = VNImageRequestHandler(cmSampleBuffer: buffer, orientation: .up)
        
        thread.runOnBackgroundThread {
            try? handler.perform([textRequest])
        }
    }
}
