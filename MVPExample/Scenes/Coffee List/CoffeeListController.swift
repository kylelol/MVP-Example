//
//  ViewController.swift
//  MVPExample
//
//  Created by Kyle Kirkland on 4/17/19.
//  Copyright © 2019 Kirkland. All rights reserved.
//

import UIKit

class CoffeeListController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loadingView: UIView!
    
    private var presenter: CoffeeListPresenter!
    
}

// MARK: - UIViewController Lifecycle

extension CoffeeListController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        presenter = CoffeeListPresenterImplementation(view: self)
        presenter.viewDidLoad()
    }
    
}

extension CoffeeListController: CoffeeListView {
   
    func startLoading() {
        displayLoading(isVisible: true)
    }
    
    func displayCoffees() {
        tableView.reloadData()
        displayLoading(isVisible: false)
    }
    
    func displayRoaster(_ roaster: Roaster) {
        let alert = UIAlertController(title: "Roaster", message: roaster.name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func displayError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: "Somethign went wrong, please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Helpers

private extension CoffeeListController {
    
    func displayLoading(isVisible: Bool) {
        func animations() {
            loadingView.alpha = isVisible ? 1.0 : 0.0
            tableView.alpha = isVisible ? 0.0 : 1.0
        }
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: .curveEaseInOut,
            animations: {
                animations()
            },
            completion: nil
        )
    }
    
}

extension CoffeeListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let coffeeCell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell") as? CoffeeTableViewCell else {
            preconditionFailure("We must have a coffee cell to continue")
        }
        
        presenter.configure(cell: coffeeCell, for: indexPath.row)
        return coffeeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

extension CoffeeListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath.row)
    }
    
}

