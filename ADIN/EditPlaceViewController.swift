//
//  EditViewController.swift
//  ADIN
//
//  Created by Islam on 12.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography

class EditPlaceViewController: UIViewController {
    
    // MARK: Properties
    
    var place: Place?
    var cellItems = [[CellItem]]()
    let themes = PlaceTheme.all
    let time = AdTime.all
    
    fileprivate lazy var footerView: AddTableViewFooterView = {
        return AddTableViewFooterView(frame: CGRect(x: 0, y: 0,
                                                    width: ScreenSize.SCREEN_WIDTH,
                                                    height: 64))
    }()
    
    lazy var tableView: UITableView = {
        return UITableView(frame: .zero, style: .grouped).then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: EditPlaceTableViewCell.self)
            $0.rowHeight = 50
            $0.tableHeaderView = UIView()
            $0.tableFooterView = self.footerView
        }
    }()
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureViews()
        configureConstriants()
        loadData()
        updateButtonDidPress()
    }
    
    // MARK: Configure Navigation Bar
    
    func configureNavBar() {
        navigationItem.title = "Изменить"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backButtonPressed))
    }
    
    // MARK: Configure Views
    
    func configureViews() {
        view.addSubview(tableView)
    }
    
    // MARK: Configure Constraints
    
    func configureConstriants() {
        constrain(tableView) {
            $0.edges == $0.superview!.edges
        }
    }
    
    // MARK: Load Data
    
    func loadData() {
        guard let place = place else { return }
        guard let price = place.price else { return }
        cellItems = [
            [CellItem(title: place.theme, icon: Icon.themeIcon)],
            [CellItem(title: place.descrip, icon: Icon.userIcon)],
            [CellItem(title: place.time, icon: Icon.clockIcon)],
            [CellItem(title: "\(price)", icon: Icon.walletIcon)]
        ]
    }
    
    // MARK: User Interaction
    
    func backButtonPressed() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func updateButtonDidPress() {
        footerView.button.setTitle("Обновить", for: .normal)
        guard let place = place else { return }
        guard let username = place.username else { return }

        footerView.button.on(.touchUpInside) { (btn) in
            btn.setTitle("Загрузка", for: .normal)
            guard let themeCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? EditPlaceTableViewCell,
                let descriptionCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? EditPlaceTableViewCell,
                let timeCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? EditPlaceTableViewCell,
                let priceCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? EditPlaceTableViewCell else { return }
           
            if let theme = themeCell.textField.text,
                let descrip = descriptionCell.textField.text,
                let time = timeCell.textField.text,
                let price = priceCell.textField.text,
                !theme.isEmpty && !descrip.isEmpty &&
                !time.isEmpty && !price.isEmpty  {
                Place.update(username: username, theme: theme, descrip: descrip, time: time, price: Int(price), completion: { (error) in
                    if error == nil {
                        Drop.down("Ваш аккаунт обновлен", state: .success)
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        guard let error = error else { return }
                        Drop.down(error, state: .error)
                    }
                })
            } else {
                Drop.down("Заполните форму", state: .warning)
            }
        }
    }
}

extension EditPlaceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as EditPlaceTableViewCell
        let item = cellItems[indexPath.section][indexPath.row]
        cell.setUp(item.title, sectionIcon: item.icon, section: indexPath.section, sender: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:  return "ТЕМАТИКА АККАУНТА"
        case 1:  return "ОПИСАНИЕ"
        case 2:  return "ВРЕМЯ РАЗМЕЩЕНИЯ"
        case 3:  return "СТОИМОСТЬ РЕКЛАМЫ"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

extension EditPlaceViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 0 ? themes.count
                                   : time.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 0 ? themes[row].rawValue
                                   : time[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: pickerView.tag)) as! EditPlaceTableViewCell
        cell.textField.text = pickerView.tag == 0 ? themes[row].rawValue
                                                  : time[row].rawValue
    }
}
