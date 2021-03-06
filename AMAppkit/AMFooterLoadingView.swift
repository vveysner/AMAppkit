//
//  AMFooterLoadingView.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/28/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

@objc public enum AMFooterState: Int {
    case undefined
    case stop
    case loading
    case failed
}

@objc open class AMFooterLoadingView: UIView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        state = .stop
    }
    
    @objc open var state: AMFooterState = .undefined {
        didSet {
            if state != oldValue {
                switch state {
                case .stop:
                    indicatorView.stopAnimating()
                    retryButton.isHidden = true
                case .loading:
                    indicatorView.startAnimating()
                    retryButton.isHidden = true
                case .failed:
                    indicatorView.stopAnimating()
                    retryButton.isHidden = false
                default: break
                }
            }
        }
    }
    @objc open var retry: (()->())?
    
    @IBOutlet open var indicatorView: UIActivityIndicatorView!
    @IBOutlet open var retryButton: UIButton!
    
    @IBAction private func retryAction(_ sender: UIButton) {
        retry?()
    }
}
