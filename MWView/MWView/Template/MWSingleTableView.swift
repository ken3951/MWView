//
//  MWSingleTableView.swift
//  MWView
//
//  Created by mwk_pro on 2019/4/1.
//  Copyright © 2019 mwk. All rights reserved.
//

import UIKit

extension UITableViewCell: MWCellLoadService {
    
}

public class MWSingleTableView: MWPagedTableView, UITableViewDelegate, UITableViewDataSource {
    
    public typealias NumberOfRowsCallBack = () -> Int
    public typealias CellCallBack = (_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell
    public typealias CellClickCallBack = (_ indexPath: IndexPath) -> Void
    public typealias CellCanEditCallBack = (_ tableView: UITableView, _ indexPath: IndexPath) -> Bool
    public typealias CellEditCallBack = (_ tableView: UITableView, _ indexPath: IndexPath) -> [UITableViewRowAction]?
    
    private var rows: Int = 0
    private var numberOfRowsCallBack: NumberOfRowsCallBack?
    private var cellCallBack: CellCallBack!
    private var cellClickCallBack: CellClickCallBack?
    private var cellCanEditCallBack: CellCanEditCallBack?
    private var cellEditCallBack: CellEditCallBack?

    public func load(numberOfRowsCallBack: @escaping NumberOfRowsCallBack, cellCallBack: @escaping CellCallBack, cellClickCallBack: CellClickCallBack? = nil) {
        self.numberOfRowsCallBack = numberOfRowsCallBack
        self.cellCallBack = cellCallBack
        self.cellClickCallBack = cellClickCallBack
        self.reloadData()
    }
    
    public func rowEdit(cellCanEditCallBack: @escaping CellCanEditCallBack, cellEditCallBack: @escaping CellEditCallBack) {
        self.cellCanEditCallBack = cellCanEditCallBack
        self.cellEditCallBack = cellEditCallBack
    }
    
    override public func reloadData() {
        self.rows = self.numberOfRowsCallBack?() ?? 0
        super.reloadData()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initData()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initData()
    }
    
    private func initData() {
        self.dataSource = self
        self.delegate = self
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellCallBack == nil {
            return UITableViewCell()
        }
        return cellCallBack(tableView,indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.cellClickCallBack?(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.cellCanEditCallBack?(tableView,indexPath) ?? false
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return cellEditCallBack?(tableView,indexPath)
    }
}
