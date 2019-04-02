//
//  ViewController.swift
//  MWView
//
//  Created by mwk_pro on 2019/4/1.
//  Copyright © 2019 mwk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: MWSingleTableView!
    
    private var dataArray: Array<String> = ["test"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.separatorInset = mw_tableViewSeparatorEdge(40, 40)
        myTableView.load(dataArrayCallBack: {[weak self] () -> Array<Any?>? in
            return self?.dataArray
        }, cellCallBack: {[weak self] (tableView,indexPath) -> UITableViewCell in
            let cell = UITableViewCell()
            cell.textLabel?.text = self?.dataArray[indexPath.row]
            return cell
        }) {[weak self] (indexPath) in
            self?.dataArray.append("test\(indexPath.row)")
            self?.myTableView.reloadData()
        }
        
        myTableView.cellEditCallBack = {[weak self] (tableView,indexPath) in
            let deleteAction = UITableViewRowAction.init(style: .normal, title: "test") { (action, indexPath) in
                
            }
            return [deleteAction]
        }
        
        
    }
    
}

