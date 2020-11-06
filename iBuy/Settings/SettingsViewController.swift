//
//  SettingsViewController.swift
//  iBuy
//
//  Created by Cesar A. Tavares on 04/11/20.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableViewSettings: UITableView!
    
    var arraySettings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSettings.delegate = self
        tableViewSettings.dataSource = self

        arraySettings.append("Avalie o app")
        arraySettings.append("Suporte")
        arraySettings.append("Relatar um problema por e-mail")
    }
    
    
    func selectedOption(option: Int) {
        switch option {
        case 0:
            UIApplication.shared.open(URL(string: "https://google.com.br")!)
        case 1:
            UIApplication.shared.open(URL(string: "https://google.com.br")!)
        default:
            UIApplication.shared.open(URL(string: "mailto://cetava@gmail.com.br")!)
        }
    }
    

}


extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOption(option: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableCell", for: indexPath) as! SettingsTableCell
        cell.setup(settings: arraySettings[indexPath.row])
        return cell
    }
    
    
}
