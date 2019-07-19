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
    
    @IBOutlet weak var goodsScrollView: UIScrollView!
    @IBOutlet weak var goodsContentView: MWTextCollectionView!
    
    private var dataArray: Array<String> = ["test"]
    private var selectTags: Array<String> = ["hgfdfb234","3454tgszsgfgg","hgfdfbf234","3454tggszsgfgg","hrhllkrjglskjer","hgfddfb234"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadGoodsView()
        
        myTableView.separatorInset = mw_tableViewSeparatorEdge(40, 40)
        myTableView.load(numberOfRowsCallBack: {[weak self] () -> Int in
            return self?.dataArray.count ?? 0
        }, cellCallBack: {[weak self] (tableView,indexPath) -> UITableViewCell in
            let cell = UITableViewCell()
            cell.textLabel?.text = self?.dataArray[indexPath.row]
            return cell
        }) {[weak self] (indexPath) in
            self?.dataArray.append("test\(indexPath.row)")
            self?.myTableView.reloadData()
        }
        
        myTableView.rowEdit(cellCanEditCallBack: { (tableView, indexPath) -> Bool in
            if indexPath.row % 2 == 1 {
                return true
            }
            return false

        }) { (tableView, indexPath) -> [UITableViewRowAction]? in
            let deleteAction = UITableViewRowAction.init(style: .normal, title: "test") { (action, indexPath) in
                
            }
            return [deleteAction]
        }
        
        
    }
    
    private func reloadGoodsView() {
        goodsContentView.adjustHeight = false
        goodsContentView.adjustWidth = true
        goodsContentView.padding = UIEdgeInsets(top: 9, left: 0, bottom: 0, right: 10)
        goodsContentView.horizontalLeading = 10
        goodsContentView.removeAllViews()
        goodsContentView.maxSize = CGSize(width: 1000000, height: 1000)
        
        for i in 0..<selectTags.count {
            let tag = selectTags[i]
            
            let goodsView = RelateGoodsView()
            goodsView.titleLabel.text = tag
            goodsView.contentView.setDeleteBtnCallBack {[weak self,weak goodsView] in
                if let index = self?.goodsContentView.childViews.firstIndex(of: goodsView!) {
                    self?.selectTags.remove(at: index)
                    self?.reloadGoodsView()
                }
            }
            goodsContentView.addView(goodsView)
        }
        
        goodsContentView.reloadData()
    }
    @IBAction func chooseAction(_ sender: UIButton) {
        switch sender.title(for: .normal) {
        case "选择器":
            let pickView = MWPickerView()
            let titles = [[1,2,3,4,5,6,77,98,74,6,53,4].map{ "\($0)" },
                          [3,43,42,4,234,24,234,234,241,31].map{ "\($0)" },
                          [12,3,32,4,534,6,4,6,47,57,].map{ "\($0)" }]
            pickView.selectCallback = { (mwPickView,indexPath) in
                mw_print_d("section=\(indexPath.section),row=\(indexPath.row)")
            }
            pickView.show(withtitles: titles, inView: mw_getCurrentRootVC()?.view)
            break
        case "年月日":
            MWTimePicker.show(inView: mw_getCurrentRootVC()?.view, timeType: .dateWithYearToDay, selectDate: nil) { (date) in
                print(date.mw_string("yyyy-MM-dd"))
            }
            break
        case "年月日时分":
            MWTimePicker.show(inView: mw_getCurrentRootVC()?.view, timeType: .dateWithYearToMinute, selectDate: nil) { (date) in
                print(date.mw_string("yyyy-MM-dd HH:mm"))
            }
            break
        case "时分":
            MWTimePicker.show(inView: mw_getCurrentRootVC()?.view, timeType: .dateWithHourToMinute, selectDate: nil) { (date) in
                print(date.mw_string("HH:mm"))
            }
            break
        case "开始结束时间":
            let startTime = MWTimeVO()
            startTime.hour = 9
            startTime.minute = 0
            
            let endTime = MWTimeVO()
            endTime.hour = 18
            endTime.minute = 0
            
            MWStartEndTimeView.showIn(view: mw_getCurrentRootVC()?.view, startTime: startTime, endTime: endTime) { (start, end) in
                print("start=\(start.hour):\(start.minute)\nend=\(end.hour):\(end.minute)")
            }
            break
        default:
            break
        }
        
    }
    @IBAction func popMenuAction(_ sender: UIButton) {
        var items: [UIButton] = []
        for _ in 0..<3 {
            let btn = UIButton()
            btn.backgroundColor = UIColor.blue
            btn.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
            items.append(btn)
        }
        MWPopMenu.show(targetView: sender, items: items, orientation: .bottom) { (index) in
            guard let index1 = index else {
                return
            }
            print("点击了第\(index1)个view")
        }
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        DispatchQueue.global().async {
            MWProgressView.show(message: "正在加载...")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                MWProgressView.dismiss()
            })
        }
    }
    
}

