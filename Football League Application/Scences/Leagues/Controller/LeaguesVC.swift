//
//  LeaguesVC.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/12/20.
//

import UIKit
import SVProgressHUD

class LeaguesVC: BaseWireframe {
    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var competitionsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var competitionsSegmentedControlBottomConstraint: NSLayoutConstraint!
    internal var presenter: LeaguesVCPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LeaguesVCPresenter(view: self)
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Methods
    @IBAction func competitionsSegmentedControlPressed(_ sender: UISegmentedControl) {
        presenter?.setAvailableStatus(competitionsSegmentedControl.selectedSegmentIndex)
    }
}

// MARK: - Presenter Delegate
extension LeaguesVC: LeaguesView {
    func navigateToLeagueDetailsScreen(with leagueId: Int) {
        Navigator.navigate(form: self, to: .leagueDetails(leagueId: leagueId))
    }
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    
    func hideIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func fetchDataSuccess() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func showError(error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.presentGenericAlert(
                viewController: self,
                title: "Error",
                message: error,
                doneButtonTitle: "Okay",
                dismissButtonTitle: nil)
        }
    }
}

// MARK: - Setup TableView
extension LeaguesVC: UITableViewDelegate, UITableViewDataSource {
    private enum TableViewConstants {
        static let nibName = "LeagueCell"
        static let cellIdentifier = "LeagueCell"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: TableViewConstants.nibName, bundle: nil),
            forCellReuseIdentifier: TableViewConstants.cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfLeagues() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewConstants.cellIdentifier,
            for: indexPath) as! LeagueCell
        presenter?.cellConfiguration(cell, for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath.row)
    }
}

// MARK: - Competitions Segmented Control Animation
extension LeaguesVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.panGestureRecognizer.translation(in: self.view).y < 0 {
            competitionsSegmentedControlBottomConstraint.constant = -100
            UIView.animate(withDuration: 0.5) { [weak self] in self?.view.layoutIfNeeded() }
        } else {
            competitionsSegmentedControlBottomConstraint.constant = 20
            UIView.animate(withDuration: 0.5) { [weak self] in self?.view.layoutIfNeeded() }
        }
    }
}
