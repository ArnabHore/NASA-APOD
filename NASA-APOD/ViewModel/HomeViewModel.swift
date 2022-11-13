//
//  HomeViewModel.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: AnyObject {
    var showError: CurrentValueSubject<String?, Never> { get }
    var showLoader: CurrentValueSubject<Bool, Never> { get }
    var apodData: CurrentValueSubject<ApodData?, Never> { get }
    var favouriteDates: [String] { get set }
    
    func getApodData(date: String?)
    func fetchFavouriteDates()
    func addToFavourite()
    func removeFromFavourite()
    func fetchAllFavourites() -> [[String: Any]]
}
class HomeViewModel: HomeViewModelProtocol {
    let showError = CurrentValueSubject<String?, Never>(nil)
    let showLoader = CurrentValueSubject<Bool, Never>(false)
    let apodData = CurrentValueSubject<ApodData?, Never>(nil)
    var favouriteDates: [String] = []
    
    /// Fetch API data
    /// - Parameters:
    ///     - date: Date for which image will be fetched. `nil` for today
    func getApodData(date: String?) {
        self.showLoader.send(true)
        let parameters = ApodRequest(api_key: Constants.apiKey, date: date)
        
        let network = NetworkHelper()
        network.callApiWith(task: .apod, parameters: parameters.toDictionary()) { [weak self] result, error  in
            if let error = error {
                self?.showError.send(error.localizedDescription)
                self?.showLoader.send(false)
            } else if let result = result,
                      let response = try? JSONDecoder().decode(ApodData.self, from: result) {
                self?.showLoader.send(false)
                self?.apodData.send(response)
            }
        }
    }
    
    /// Fetch only favourite dates
    func fetchFavouriteDates() {
        let coreDataManager = CoreDataManager()
        if let dates = coreDataManager.fetchData(properties: ["date"]) as? [String] {
            self.favouriteDates = dates
        }
    }
    
    /// Add data as favourite in db
    func addToFavourite() {
        if let apodData = self.apodData.value {
            let coreDataManager = CoreDataManager()
            coreDataManager.saveData(imgData: apodData.toDictionary())
        }
    }
    
    /// Remove current data from favourite in db
    func removeFromFavourite() {
        if let date = self.apodData.value?.date {
            let coreDataManager = CoreDataManager()
            coreDataManager.deleteData(date: date)
        }
    }
    
    /// Fetch all favourites
    func fetchAllFavourites() -> [[String: Any]] {
        let coreDataManager = CoreDataManager()
        if let list = coreDataManager.fetchData(properties: nil) as? [[String: Any]] {
            return list
        }
        return []
    }
}
