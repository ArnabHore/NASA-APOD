//
//  HomeViewController.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 12/11/22.
//

import UIKit
import Combine
import Kingfisher

final class HomeViewController: UIViewController {
    @IBOutlet weak var titleSuperView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var explanationSuperView: UIView!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var explanationUpButton: UIButton!
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .systemBackground
        return datePicker
    }()
    
    let homeViewModel: HomeViewModelProtocol = HomeViewModel()
    var disposables = Set<AnyCancellable>()

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.setUpBindings()
        self.homeViewModel.getApodData(date: nil)
        self.homeViewModel.fetchFavouriteDates()
    }
    
    // MARK: - Methods
    /// UI elements setup
    private func setupUI() {
        self.navigationItem.leftBarButtonItem = self.getBarButton(imageName: "calendar", selector: #selector(leftBarButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = self.getBarButton(imageName: "list.bullet", selector: #selector(rightBarButtonTapped(_:)))
        self.datePicker.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
    }
    
    /// Create bar buttons
    private func getBarButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: self, action: selector)
        barButton.tintColor = UIColor.label
        return barButton
    }
    
    /// Set up subscriber to observe data published from viewModel
    private func setUpBindings() {
        /// Error subscriber
        self.homeViewModel.showError.sink(receiveValue: { [weak self] errorMessage in
            guard let error = errorMessage else { return }
            DispatchQueue.main.async {
                self?.showAlert(title: "Error", message: error)
            }
        }).store(in: &disposables)
        
        /// Loader subscriber
        self.homeViewModel.showLoader.sink(receiveValue: { [weak self] shouldShow in
            DispatchQueue.main.async {
                shouldShow ? self?.view.showLoader() : self?.view.hideLoader()
            }
        }).store(in: &disposables)
    
        /// API response subscriber
        self.homeViewModel.apodData.sink(receiveValue: { [weak self] response in
            DispatchQueue.main.async {
                guard let response = response else { return }
                self?.setup(response: response)
            }
        }).store(in: &disposables)
    }
    
    /// Setup UI after getting API response
    private func setup(response: ApodData) {
        self.title = response.date?.toDate(format: "MMMM dd, yyyy")
        self.titleLabel.text = response.title
        self.mainImageView.setImage(url: response.url)
        self.explanationLabel.text = response.explanation
        if let date = response.date, self.homeViewModel.favouriteDates.contains(date) {
            self.favouriteButton.isSelected = true
        } else {
            self.favouriteButton.isSelected = false
        }
        self.favouriteButton.isHidden = false
        self.explanationUpButton.isHidden = false
    }
    
    /// Add inline DatePicker into view
    private func showDatePicker() {
        self.mainImageView.alpha = 0.5
        self.view.addSubview(self.datePicker)
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.datePicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    /// Datepicker action
    @objc func handleDateSelection() {
        self.datePicker.removeFromSuperview()
        self.mainImageView.alpha = 1
        self.homeViewModel.getApodData(date: self.datePicker.date.toDate(format: "yyyy-MM-dd"))
    }
    
    // MARK: - Actions
    @IBAction func leftBarButtonTapped(_ sender: UIButton) {
        self.showDatePicker()
    }
    
    @IBAction func rightBarButtonTapped(_ sender: UIButton) {
        let fav = self.homeViewModel.fetchAllFavourites()
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FavouriteViewController") as? FavouriteViewController {
            vc.favouriteList = fav
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            self.homeViewModel.removeFromFavourite()
        } else {
            self.homeViewModel.addToFavourite()
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func explanationUpButtonTapped(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExplanationViewController") as? ExplanationViewController {
            vc.explanationText = self.explanationLabel.text
            self.present(vc, animated: true)
        }
    }
}
