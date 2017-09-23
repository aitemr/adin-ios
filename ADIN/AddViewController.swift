//
//  AddViewController.swift
//  ADIN
//
//  Created by Islam on 04.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import Sugar
import Cartography
import Reusable
import Tactile

class AddViewController: UIViewController {
    
    // MARK: Properties
    
    let themes = PlaceTheme.all
    let time = AdTime.all
    
    let cellItems = [
        [CellItem(title: "Например aitemr", icon: Icon.instagramIcon)],
        [CellItem(title: "Выберите тему", icon: Icon.themeIcon)],
        [CellItem(title: "Кратко опишите про свой аккаунт", icon: Icon.userIcon)],
        [CellItem(title: "1/24 - час в топе сутки в ленте", icon: Icon.clockIcon)],
        [CellItem(title: "Стоимость рекламы", icon: Icon.walletIcon)]
    ]
    
    fileprivate lazy var footerView: AddTableViewFooterView = {
        return AddTableViewFooterView(frame: CGRect(x: 0, y: 0,
                                                    width: ScreenSize.SCREEN_WIDTH,
                                                    height: 64))
    }()
    
    lazy var tableView: UITableView = {
        return UITableView(frame: .zero, style: .grouped).then {
            $0.delegate = self
            $0.dataSource = self
            $0.rowHeight = 50
            $0.register(cellType: AddTableViewCell.self)
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
        addButtonDidPress()
    }
    
    // MARK: Configure Navigation Bar
    
    func configureNavBar() {
        navigationItem.title = "Добавить"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backButtonPressed))
    }
    
    // MARK: Configure Views
    
    func configureViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    // MARK: Configure Constraints
    
    func configureConstriants() {
        constrain(tableView) {
            $0.edges == $0.superview!.edges
        }
    }
    
    // MARK: User Interaction
    
    func backButtonPressed() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func addButtonDidPress() {
        footerView.button.on(.touchUpInside) { (btn) in
            btn.setTitle("Загрузка", for: .normal)
            guard let usernameCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddTableViewCell,
                let themeCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? AddTableViewCell,
                let descriptionCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? AddTableViewCell,
                let timeCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? AddTableViewCell,
                let priceCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? AddTableViewCell else { return }
            
            if let username = usernameCell.textField.text,
                let theme = themeCell.textField.text,
                let descrip = descriptionCell.textField.text,
                let time = timeCell.textField.text,
                let price = priceCell.textField.text,
                !username.isEmpty && !theme.isEmpty &&
                    !descrip.isEmpty && !time.isEmpty && !price.isEmpty  {
                Place.add(username: username, theme: theme, descrip: descrip, time: time, price: Int(price), completion: { (error) in
                    if error == nil {
                        Drop.down("Ваш аккаунт добавлен", state: .success)
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

extension AddViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as AddTableViewCell
        let item = cellItems[indexPath.section][indexPath.row]
        cell.setUp(item.title, sectionIcon: item.icon, section: indexPath.section, sender: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:  return "НАЗВАНИЕ АККАУНТА"
        case 1:  return "ТЕМАТИКА АККАУНТА"
        case 2:  return "ОПИСАНИЕ"
        case 3:  return "ВРЕМЯ РАЗМЕЩЕНИЯ"
        case 4:  return "СТОИМОСТЬ РЕКЛАМЫ"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension AddViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 1 ? themes.count
            : time.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 1 ? themes[row].rawValue
            : time[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: pickerView.tag)) as! AddTableViewCell
        cell.textField.text = pickerView.tag == 1 ? themes[row].rawValue
            : time[row].rawValue
    }
}
