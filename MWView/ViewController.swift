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
    
    @IBAction func submitAction(_ sender: UIButton) {
        DispatchQueue.global().async {
            MWProgressView.show(message: "正在加载...")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                MWProgressView.dismiss()
            })
        }
    }
    
}

