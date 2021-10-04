//
//  FSDataLoadingVC.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 1.10.2021.
//

import UIKit

class FSDataLoadingVC: UIViewController {

    private var containerView: UIView?
    private var emptyStateView: FSEmptyStateView?


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    func showLoadingView() {
        // Make sure we don't create more than 1 loading view
        if containerView != nil {
            return
        }
        
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView!)
        
        containerView?.backgroundColor = .lightGray
        containerView?.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView?.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView?.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.center(inView: containerView!)
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        containerView?.removeFromSuperview()
        containerView = nil
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        // make sure to never add more than 1 emptyStateView
        if emptyStateView == nil {
            emptyStateView = FSEmptyStateView(message: message)
            emptyStateView?.frame = view.bounds
            view.addSubview(emptyStateView!)
        }
    }

    
    func dismissEmptyStateView() {
        emptyStateView?.removeFromSuperview()
        emptyStateView = nil
    }
}
