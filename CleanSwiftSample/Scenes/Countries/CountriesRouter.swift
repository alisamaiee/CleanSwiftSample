//
//  CountriesRouter.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/9/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol CountriesRoutingLogic {
    /// Must be called on main thread
    func navigateTo(vc: UIViewController)
    /// Must be called on main thread
    func present(vc: UIViewController)
}

class CountriesRouter: NSObject, CountriesRoutingLogic {
    
    weak var viewController: CountriesViewController?
    
    // MARK: Routing
    
    func navigateTo(vc: UIViewController) {
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func present(vc: UIViewController) {
        self.viewController?.present(vc, animated: true, completion: nil)
    }
}
