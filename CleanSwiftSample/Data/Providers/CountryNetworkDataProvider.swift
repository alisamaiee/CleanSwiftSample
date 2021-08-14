//
//  NetworkDataProvider.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation
import Moya
 
class CountryNetworkDataProvider: CountryDataProvider {
    
    let provider = MoyaProvider<CountriesAPIService>()
    
    func setSelected(key: String, selected: Bool) -> Result<Country> {
        let error = RuntimeError("setSelected not supported in this sample app apis")
        return Result.Failed(error: error)
    }
    
    func getAll() -> Result<[Country]> {
        var allData = [Country]()
        var resultError: MoyaError?
        
        let latch = CountDownLatch(counter: 1)
        provider.request(.getCountriesEU) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                Logger.printToConsole("getCountriesEU request response recieved with \(statusCode) and response \(data)")
                let decoder = JSONDecoder()
                do {
                    let country = try decoder.decode([Country].self, from: data)
                    Logger.printToConsole(country)
                    allData = country
                } catch {
                    Logger.printToConsole(error.localizedDescription)
                }
                latch.countDown()
            case let .failure(error):
                Logger.printToConsole(error)
                resultError = error
                latch.countDown()
            }
        }
        latch.await()
        
        let result: Result<[Country]>
        if let strongError = resultError {
            result = .Failed(error: strongError)
        } else {
            result = .Success(data: allData)
        }
        return result
    }
    
    func get(key: String) -> Result<Country> {
        let error = RuntimeError("network get not supported in this sample app")
        return Result.Failed(error: error)
    }
    
    func put(key: String, value: Country) -> Result<Bool> {
        let error = RuntimeError("network put not supported in this sample app")
        return Result.Failed(error: error)
    }
    
    func putMany(map: [String : Country]) -> Result<Bool> {
        let error = RuntimeError("network putMany not supported in this sample app")
        return Result.Failed(error: error)
    }
    
    func remove(key: String) -> Result<Bool> {
        let error = RuntimeError("network remove not supported in this sample app")
        return Result.Failed(error: error)
    }
}
