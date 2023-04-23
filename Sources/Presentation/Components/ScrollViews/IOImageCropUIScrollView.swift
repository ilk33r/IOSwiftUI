//
//  IOImageCropUIScrollView.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.02.2023.
//

import Foundation
import UIKit

final public class IOImageCropUIScrollView: UIScrollView {
    
    // MARK: - Publics
    
    public var image: UIImage? {
        didSet {
            self.imageUpdated()
        }
    }
    
    // MARK: - Privates
    
    private var viewConfigured = false
    private var imageViewWidthAnchor: NSLayoutConstraint?
    private var imageViewHeightAnchor: NSLayoutConstraint?
    private weak var imageView: UIImageView?
    
    // MARK: - View Lifecycle

    override public func didMoveToWindow() {
        super.didMoveToWindow()
        
        if self.superview != nil && !self.viewConfigured {
            self.viewConfigured = true
            self.configureCropView()
        }
    }
    
    // MARK: - Crop View Methods
    
    public func cropImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(self.bounds)
        
            // CGContextScaleCTM(ctx, self.zoomScale, self.zoomScale);
            context.translateBy(x: -self.contentOffset.x, y: -self.contentOffset.y)
        
            context.setFillColor(UIColor.white.cgColor)
            context.fill(self.bounds)
            
            self.layer.render(in: context)
        
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        
            return img
        }
        
        return nil
    }
    
    // MARK: - UI
    
    private func configureCropView() {
        self.delegate = self
        
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        self.addSubview(imageView)
        self.imageView = imageView
        
        self.imageViewWidthAnchor = self.imageView?.widthAnchor.constraint(equalToConstant: 0)
        self.imageViewHeightAnchor = self.imageView?.heightAnchor.constraint(equalToConstant: 0)
        
        let trailingAnchor = self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        trailingAnchor?.priority = .defaultLow
        
        let bottomAnchor = self.imageView?.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        bottomAnchor?.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            self.imageView!.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            trailingAnchor!,
            bottomAnchor!,
            self.imageViewWidthAnchor!,
            self.imageViewHeightAnchor!
        ])
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = true
        self.delaysContentTouches = false
    
        self.imageView?.image = self.image
        self.imageViewWidthAnchor?.constant = self.image?.size.width ?? 0
        self.imageViewHeightAnchor?.constant = self.image?.size.height ?? 0
        self.imageUpdated()
    }
    
    // MARK: - Helper Methods

    private func imageUpdated() {
        self.imageView?.image = self.image
        self.imageViewWidthAnchor?.constant = self.image?.size.width ?? 0
        self.imageViewHeightAnchor?.constant = self.image?.size.height ?? 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(350)) { [weak self] in
            self?.updateScales()
        }
    }
    
    private func updateScales() {
        let imageWidth = self.image?.size.width ?? 0
        let viewWidth = self.frame.size.width
        let minScale = viewWidth / imageWidth
        
        if minScale <= 0 {
            return
        }
        
        self.minimumZoomScale = minScale
        self.maximumZoomScale = 1.0 + minScale
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(350)) { [weak self] in
            self?.setZoomScale(minScale, animated: true)
        }
    }
}

extension IOImageCropUIScrollView: UIScrollViewDelegate {
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.imageView
    }
}
