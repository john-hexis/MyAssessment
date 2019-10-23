//
//  ViewController.swift
//  SPHTest
//
//  Created by John Harries on 15/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation
import UIKit

class MobileUsageListViewController: UIViewController {
    fileprivate var presenter: MobileUsageListPresenterInput?
    
    @IBOutlet weak var mobileUsageTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initView()
        self.initViper()
        self.presenter?.loadViewData()
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        self.presenter?.loadViewData()
    }
}

extension MobileUsageListViewController: ViewInput {
    func initView() {
        self.mobileUsageTableView.delegate = self
        self.mobileUsageTableView.dataSource = self
        
        MobileUsageTableViewCell.register(to: self.mobileUsageTableView, with: MobileUsageTableViewCell.identifier)
        
    }
    
    func initViper() {
        guard let navController = self.navigationController else { return }
        self.presenter = MobileUsageListPresenter(output: self, navController: navController)
        self.presenter?.initRouter(navController: self.navigationController!)
        self.presenter?.initInteractor()
    }
    
    func deinitView() {
        
    }
}

extension MobileUsageListViewController: MobileUsageListPresenterOutput {
    func showPopupAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
            UIAlertAction in
            alertController.dismiss(animated: true, completion: nil)
        }

        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateView() {
        self.mobileUsageTableView.reloadData()
    }
}

extension MobileUsageListViewController: UITableViewDelegate {
    
}

extension MobileUsageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.presenter?.recordDictionary[section])?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MobileUsageTableViewCell.identifier, for: indexPath) as? MobileUsageTableViewCell else {
            return UITableViewCell()
        }
        
        guard let record = self.presenter?.recordDictionary[indexPath.section] else {
            return UITableViewCell()
        }
        
        cell.labelText.text = String(format: "%@ [%@]", String(record.rows[indexPath.row].quarter), String(record.rows[indexPath.row].volumeUsage))
        cell.delegate = self
        if record.rows[indexPath.row].isDecreased {
            cell.setImgToDecrease()
        } else {
            cell.setImgToIncrease()
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.recordCount.sections ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let record = self.presenter?.recordDictionary[section] else {
            return ""
        }
        return String(format: "%@ - %@", String(record.section.year), String(record.section.total))
    }
}

extension MobileUsageListViewController: MobileUsageTableViewCellDelegate {
    func onDecreaseTapped() {
        self.showPopupAlert(message: "Mobile usage volume had been decreased")
    }
}
