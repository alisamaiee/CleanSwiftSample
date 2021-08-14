//
//  SelectCountriesRouter.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol SelectCountriesRoutingLogic {
    func popViewController()
}

class SelectCountriesRouter: NSObject, SelectCountriesRoutingLogic {
    weak var viewController: SelectCountriesViewController?
    
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
