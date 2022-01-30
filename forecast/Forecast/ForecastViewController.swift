//
//  ForecastViewController.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 15-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import UIKit

protocol ForecastViewControllerOutput {
    func loadForecast(at latitude: Double, longitude: Double)
}

protocol ForecastViewControllerAction {
    // TODO if needed
}

final class ForecastViewController: UIViewController {
    
    // MARK: - Properties
    
    var output: ForecastViewControllerOutput!
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var forecast: Forecast.ViewModel.Forecast?
    
    private var activityView: UIActivityIndicatorView?
    private var pageController: UIPageViewController?
        
    override func viewDidLoad() {
        configurePageController()
        showActivityIndicator()
        output.loadForecast(at: latitude, longitude: longitude)

    }
    
    // MARK: Private Methods
    private func configurePageController() {
        let controller = UIPageViewController(transitionStyle: .scroll,
                                              navigationOrientation: .horizontal,
                                              options: nil)
        controller.dataSource = self
        controller.view.backgroundColor = .white
        controller.view.frame = CGRect(x: 0,
                                       y: 0,
                                       width: view.frame.width,
                                       height: view.frame.height)
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
        pageController = controller
    }
    
    private func displayPageController() {
        guard let forecast = forecast,
              let pageController = pageController else {
            return
        }
        
        let controller = DetailTableViewController(forecast: forecast.list[0],
                                                   page: 0,
                                                   delegate: self)
        
        pageController.setViewControllers([controller],
                                          direction: .forward,
                                          animated: false)
    }
    
    private func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = view.center
        view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    private func hideActivityIndicator() {
        if activityView != nil {
            activityView?.stopAnimating()
        }
    }
}

// MARK: - ForecastPresenterOutput
extension ForecastViewController: ForecastPresenterOutput {
    func showForecast(for model: Forecast.ViewModel.Forecast) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.hideActivityIndicator()
            self.forecast = model
            self.displayPageController()
        }
    }
    
    func showError(for model: Forecast.ViewModel.Error) {
        DispatchQueue.main.async() { [weak self] in
            guard let self = self else {
                return
            }
            
            self.hideActivityIndicator()
            let errorView = ForecastErrorView(viewModel: model)
            self.view.addSubview(errorView)
            errorView.configureConstraints(with: self.view)
            self.displayDetailHeader(title: Constants.ErrorMessage.headerTitle)
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension ForecastViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let forecast = forecast,
              let currentController = viewController as? DetailTableViewController else {
            return nil
        }
        
        let currentPage = currentController.page ?? 0
        let nextPage = currentPage - 1
        
        if nextPage >= 0 {
            let nextController = DetailTableViewController(forecast: forecast.list[nextPage],
                                                           page: nextPage,
                                                           delegate: self)
            return nextController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let forecast = forecast,
              let currentController = viewController as? DetailTableViewController else {
            return nil
        }
        
        let currentPage = currentController.page ?? 0
        let nextPage = currentPage + 1
        let totalPages = forecast.list.count
        
        if totalPages > nextPage {
            let nextController = DetailTableViewController(forecast: forecast.list[nextPage],
                                                           page: nextPage,
                                                           delegate: self)
            return nextController
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return forecast?.list.count ?? 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

// MARK: - DetailViewDelegate
extension ForecastViewController: DetailViewDelegate {
    func displayDetailHeader(title: String) {
        self.title = title
    }
}
