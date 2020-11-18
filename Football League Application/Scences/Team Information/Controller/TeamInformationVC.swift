//
//  TeamInformationVC.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import UIKit
import SVProgressHUD

class TeamInformationVC: BaseWireframe {
    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    internal var presenter: TeamInformationVCPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        setupNavBar(navBarTitle: .TeamInformation)
        setupTableView()
        presenter?.viewDidLoad()
    }
}

// MARK: - Presenter Delegate
extension TeamInformationVC: TeamInformationView {
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
            self.tableView.isHidden = false
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
extension TeamInformationVC: UITableViewDelegate, UITableViewDataSource {
    private enum TableViewConstants {
        static let PlayerCellNibName = "PlayerCell"
        static let PlayerCellCellIdentifier = "PlayerCell"
        static let TeamInfoCellNibName = "TeamInfoCell"
        static let TeamInfoCellCellIdentifier = "TeamInfoCell"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: TableViewConstants.PlayerCellNibName, bundle: nil),
            forCellReuseIdentifier: TableViewConstants.PlayerCellCellIdentifier)
        tableView.register(
            UINib(nibName: TableViewConstants.TeamInfoCellNibName, bundle: nil),
            forCellReuseIdentifier: TableViewConstants.TeamInfoCellCellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection(for: section) ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter?.titleForHeaderInSection(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let teamInfoCell = tableView.dequeueReusableCell(
                withIdentifier: TableViewConstants.TeamInfoCellCellIdentifier,
                for: indexPath) as! TeamInfoCell
            presenter?.teamInfoCellConfiguration(teamInfoCell, for: indexPath.row)
            return teamInfoCell
        } else {
            let playerCell = tableView.dequeueReusableCell(
                withIdentifier: TableViewConstants.PlayerCellCellIdentifier,
                for: indexPath) as! PlayerCell
            presenter?.playerCellConfiguration(playerCell, for: indexPath.row)
            return playerCell
        }
    }
}
