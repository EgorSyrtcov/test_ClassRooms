//
//  Main.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import UIKit

final class Main: UIViewController {

    // MARK: - Properties
    var presenter: MainViewPresenterProtocol!
    
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var filterTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.fetchClassRooms()
        setupNavigationBar()
        setupSearchView()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        let label = UILabel()
        label.textColor = UIColor.navigationLabelColor()
        label.font = UIFont(name: "Helvetica-Regular", size: 24)
        label.text = "My Classroom"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        //Delete separator on navBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    private func setupSearchView() {
        searchView.backgroundColor = UIColor.searchColor()
        searchView.layer.cornerRadius = searchView.layer.bounds.width / 2
        filterTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setupTableView() {
        tableView.registerNibForCell(ClassCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 130
    }
}

extension Main: MainViewProtocol {
    
    func showSpinner() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
            self?.activityIndicator.isHidden = false
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.tableView.reloadData()
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension Main: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClassCell.identifier,
                                                       for: indexPath) as? ClassCell else { return UITableViewCell() }
        let classRoom = presenter.getClassRoom(by: indexPath)
        cell.setupClassRoom(classRoom)
        return cell
    }
}

extension Main: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        presenter.filteringResult(with: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


