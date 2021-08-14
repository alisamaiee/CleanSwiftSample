//
//  SelectCountriesPresenter.swift
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

protocol SelectCountriesPresentationLogic {
    /// To update related cell after applying in server or DB if needed
    func present(update forCountry: SelectCountries.Response.ToggleCountry)
    /// To reload whole data
    func present(countries: SelectCountries.Response.FetchCountry)
    /// To show progress while loading
    func setProgress(visibility: Bool)
    /// To present alerts or sth. if needed
    func present(error: Error)
}

class SelectCountriesPresenter {
    weak var viewController: SelectCountriesDisplayLogic?
}

// MARK: SelectCountriesPresentationLogic extension

extension SelectCountriesPresenter: SelectCountriesPresentationLogic {
    func setProgress(visibility: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setProgress(visibility: visibility)
        }
    }
    
    func present(update forCountry: SelectCountries.Response.ToggleCountry) {
        let country = SelectCountries.ViewModel.Country(title: forCountry.name, selected: forCountry.selected)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.updateCell(with: country)
        }
    }

    func present(countries: SelectCountries.Response.FetchCountry) {
        var viewModelCountries = [SelectCountries.ViewModel.Country]()
        if let strongCountries = countries.countries {
            for country in strongCountries {
                let viewModelCountry = SelectCountries.ViewModel.Country(title: country.name, selected: country.selected)
                viewModelCountries.append(viewModelCountry)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.reloadData(viewModel: SelectCountries.ViewModel.ReloadCountries(countries: viewModelCountries))
        }
    }

    func present(error: Error) {
        DispatchQueue.main.async { [weak self] in
            // TODO: Need to work on more user-friendly error handling
            self?.viewController?.showAlert(message: error.localizedDescription)
        }
    }
}