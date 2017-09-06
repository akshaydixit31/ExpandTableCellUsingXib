//
//  ViewController.swift
//  ExpandTableCellUsingXib
//
//  Created by Appinventiv Technologies on 06/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//---------------- Outlet's -------------
    @IBOutlet weak var expendedTableView: UITableView!
//--------------- Variable's ------------
    
    let itemInList = ["Bike's","BiCycle","Car's"]
    let bikeArray = ["Accura","Ducati Bikes","Hero","Honda","TVS","Yamaha"]
    let bicycleArray = ["Avon","Atlas","Hero","Montra","Suncross"]
    let cars = ["Audi","BMW","Ford","Maruti"]
    var expandedSections : NSMutableSet = ["anni"]
    var clickOnButton = false
//---------- ViewDidLoad -----------
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerNib = UINib(nibName: "HeaderCustom", bundle: nil)                         //------ Register nib for headerView.........
        expendedTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderCustomId")
        
        let cellNib = UINib(nibName: "ExpendedCustomCell", bundle: nil)
        expendedTableView.register(cellNib, forCellReuseIdentifier: "ExpendedCustomCellId")     //-------- Register nib for Cell..........
        expendedTableView.dataSource = self
        expendedTableView.delegate = self
    }
//--------- Function for action on header button ----------
 @objc func headerButtonAction(sender: UIButton){
    let section = sender.tag
    print(section)
    let shouldExpand = !expandedSections.contains(section)
    if (shouldExpand) {
       expandedSections.add(section)
    } else {
        expandedSections.remove(section)
    }
    self.expendedTableView.reloadSections([section], with: .automatic)
    
    }
   
    

}
//============== Extension of ViewController =============
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemInList.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderCustomId") as? HeaderCustom else {fatalError("Header not found")}
        header.headerButton.tag = section
        if (expandedSections.contains(section)) {    // ----- for changing button image on click..........
            header.upDownImage.image = UIImage(named: "up")
        } else {
            header.upDownImage.image = UIImage(named: "down")
        }
        header.contentView.backgroundColor = UIColor.orange
        header.headerButton.setTitle(itemInList[section], for: .normal)
        header.headerButton.addTarget(self, action: #selector(ViewController.headerButtonAction(sender:)), for: .touchUpInside)
        return header
    }
//    --------------------------------------------------
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {        // --- Header height....
        return 80
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {        // ---- Gap between section's...
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {          // ---- Height for row's...
        return 150
    }
//    -----------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
            switch section {
            case 0:
                return bikeArray.count
            case 1:
                return bicycleArray.count
            default:
                return cars.count
            }
        } else {
            return 0
        }
    }
//--------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "ExpendedCustomCellId", for: indexPath) as? ExpendedCustomCell else{fatalError("Cell Not Found")}
        switch indexPath.section {
        case 0:
            cell.cellDataLabel.text = bikeArray[indexPath.row]
        case 1:
            cell.cellDataLabel.text = bicycleArray[indexPath.row]
       default:
            cell.cellDataLabel.text = cars[indexPath.row]
        }
        return cell
    }
//    -------------------
    func animationDuration(itemIndex:NSInteger, type:CAAnimation)-> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [1, 1, 1] // timing animation for each view
        return TimeInterval(durations[itemIndex])
    }
    
}
