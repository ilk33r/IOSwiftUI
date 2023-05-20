//
//  IOImagePickerView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import SwiftUI

public struct IOImagePickerView: UIViewControllerRepresentable {

    // MARK: - Defs
    
    public typealias PickHandler = (_ image: UIImage) -> Void
    
    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        private let dismissHandler: () -> Void
        private let pickHandler: PickHandler?

        init(dismissHandler: @escaping () -> Void, pickHandler: PickHandler?) {
            self.dismissHandler = dismissHandler
            self.pickHandler = pickHandler
        }

        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let editedImage = info[.editedImage] as? UIImage
            let originalImage = info[.originalImage] as? UIImage
            guard let image = editedImage ?? originalImage else {
                dismissHandler()
                return
            }
            pickHandler?(image)
            dismissHandler()
        }

        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            dismissHandler()
        }
    }
    
    // MARK: - Privates
    
    @Environment(\.presentationMode) private var presentationMode
    
    private let allowEditing: Bool
    private let cameraCaptureMode: UIImagePickerController.CameraCaptureMode
    private let handler: PickHandler?
    private let sourceType: UIImagePickerController.SourceType

    // MARK: - Initialization Methods
    
    public init(
        sourceType: UIImagePickerController.SourceType,
        allowEditing: Bool = false,
        cameraCaptureMode: UIImagePickerController.CameraCaptureMode = .photo,
        handler: PickHandler? = nil
    ) {
        self.sourceType = sourceType
        self.allowEditing = allowEditing
        self.cameraCaptureMode = cameraCaptureMode
        self.handler = handler
    }

    // MARK: - Representable
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.allowsEditing = allowEditing
        
        if sourceType == .camera {
            picker.cameraCaptureMode = cameraCaptureMode
        }
        
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator {
            presentationMode.wrappedValue.dismiss()
        } pickHandler: { image in
            handler?(image)
        }
    }
}
