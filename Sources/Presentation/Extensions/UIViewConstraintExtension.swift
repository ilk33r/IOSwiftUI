//
//  UIViewConstraintExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import UIKit
import IOSwiftUICommon

public extension UIView {
    
    // MARK: - Getters
    
    var bottomConstraint: NSLayoutConstraint? {
        let topConstraints = self.constraints.filter { $0.firstAttribute == .bottom }
        let filteredConstraints = topConstraints.filter { $0.firstItem?.isEqual(self) ?? false }
        
        if !filteredConstraints.isEmpty {
            return filteredConstraints.first
        }
        
        let filteredConstraint = self.superview?.constraints.first(where: { [weak self] constraint in
            return constraint.firstAnchor.isEqual(self?.bottomAnchor)
        })
        
        return filteredConstraint
    }
    
    var topConstraint: NSLayoutConstraint? {
        let topConstraints = self.constraints.filter { $0.firstAttribute == .top }
        let filteredConstraints = topConstraints.filter { $0.firstItem?.isEqual(self) ?? false }
        
        if !filteredConstraints.isEmpty {
            return filteredConstraints.first
        }
        
        let filteredConstraint = self.superview?.constraints.first(where: { [weak self] constraint in
            return constraint.firstAnchor.isEqual(self?.topAnchor)
        })
        
        return filteredConstraint
    }
    
    // MARK: - Initialization Methods
    
    convenience init(containerView: UIView, constraints: [IOConstraints]) {
        self.init()
        containerView.addSubview(view: self, constraints: constraints)
    }
    
    func addSubview(view: UIView, constraints: [IOConstraints]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        self.addConstraints(view: view, constraints: constraints)
    }
    
    func addConstraints(view: UIView, constraints: [IOConstraints]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsForActivate = [NSLayoutConstraint]()
        
        for constraint in constraints {
            if constraint.rawValue == .safeAreaTop {
                constraintsForActivate.append(view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: constraint.sizeValue))
            }
            
            if constraint.rawValue == .safeAreaTrailing {
                constraintsForActivate.append(view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: constraint.sizeValue))
            }
            
            if constraint.rawValue == .safeAreaLeading {
                constraintsForActivate.append(view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: constraint.sizeValue))
            }
            
            if constraint.rawValue == .safeAreaBottom {
                constraintsForActivate.append(view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: constraint.sizeValue))
            }
            
            if constraint.rawValue == .top {
                constraintsForActivate.append(view.topAnchor.constraint(equalTo: self.topAnchor, constant: constraint.sizeValue))
            }
            
            if constraint.rawValue == .trailing {
                constraintsForActivate.append(view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constraint.sizeValue))
            }
            
            if constraint.rawValue == .leading {
                constraintsForActivate.append(view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constraint.sizeValue))
            }
            
            if constraint.rawValue == .bottom {
                constraintsForActivate.append(view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: constraint.sizeValue))
            }
            
            if constraint.rawValue == .centerX {
                constraintsForActivate.append(view.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: constraint.sizeValue))
            }
            
            if constraint.rawValue == .centerY {
                constraintsForActivate.append(view.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: constraint.sizeValue))
            }
            
            if constraint.rawValue == .equalWidth {
                constraintsForActivate.append(view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: constraint.sizeValue))
            }
            
            if constraint.rawValue == .equalHeight {
                constraintsForActivate.append(view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: constraint.sizeValue))
            }
        }
        
        NSLayoutConstraint.activate(constraintsForActivate)
    }

    // MARK: - Constraints
    
    @discardableResult
    func addBottom(_ bottomAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let bottomConstraints = self.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraints.priority = priority
        
        NSLayoutConstraint.activate([
            bottomConstraints
        ])
        
        return bottomConstraints
    }
    
    @discardableResult
    func addEqualHeight(_ heightAnchor: NSLayoutDimension) -> NSLayoutConstraint {
        let equalHeightConstraints = self.heightAnchor.constraint(equalTo: heightAnchor)
        
        NSLayoutConstraint.activate([
            equalHeightConstraints
        ])
        
        return equalHeightConstraints
    }
    
    @discardableResult
    func addEqualWidth(_ widthAnchor: NSLayoutDimension) -> NSLayoutConstraint {
        let equalWidthConstraints = self.widthAnchor.constraint(equalTo: widthAnchor)
        
        NSLayoutConstraint.activate([
            equalWidthConstraints
        ])
        
        return equalWidthConstraints
    }
    
    @discardableResult
    func addHeight(_ constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let heightAnchor = self.heightAnchor.constraint(equalToConstant: constant)
        heightAnchor.priority = priority
        
        NSLayoutConstraint.activate([
            heightAnchor
        ])
        
        return heightAnchor
    }
    
    @discardableResult
    func addLeading(_ leadingAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let leadingAnchor = self.leadingAnchor.constraint(equalTo: leadingAnchor)
        leadingAnchor.priority = priority
        
        NSLayoutConstraint.activate([
            leadingAnchor
        ])
        
        return leadingAnchor
    }
    
    @discardableResult
    func addMinHeight(_ heightAnchor: NSLayoutDimension, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let heightAnchor = self.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor)
        heightAnchor.priority = priority
        
        NSLayoutConstraint.activate([
            heightAnchor
        ])
        
        return heightAnchor
    }
    
    @discardableResult
    func addMinHeight(_ heightConstraint: CGFloat) -> NSLayoutConstraint {
        let heightAnchor = self.heightAnchor.constraint(greaterThanOrEqualToConstant: heightConstraint)
        
        NSLayoutConstraint.activate([
            heightAnchor
        ])
        
        return heightAnchor
    }
    
    @discardableResult
    func addRatio(ratio: CGFloat) -> NSLayoutConstraint {
        let ratioConstraints = self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: ratio)
        
        NSLayoutConstraint.activate([
            ratioConstraints
        ])
        
        return ratioConstraints
    }
    
    @discardableResult
    func addTop(_ topAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let topConstraints = self.topAnchor.constraint(equalTo: topAnchor)
        topConstraints.priority = priority
        
        NSLayoutConstraint.activate([
            topConstraints
        ])
        
        return topConstraints
    }
    
    @discardableResult
    func addTrailing(_ trailingAnchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        let trailingAnchor = self.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        NSLayoutConstraint.activate([
            trailingAnchor
        ])
        
        return trailingAnchor
    }
    
    @discardableResult
    func addWidth(_ constant: CGFloat) -> NSLayoutConstraint {
        let widthAnchor = self.widthAnchor.constraint(equalToConstant: constant)
        
        NSLayoutConstraint.activate([
            widthAnchor
        ])
        
        return widthAnchor
    }
}
