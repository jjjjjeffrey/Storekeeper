//
//  TableViewProtocol.swift
//  tianshidaoyi2
//
//  Created by zengdaqian on 2017/2/15.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation
import UIKit

public protocol TableViewCompatible {
    
    var reuseIdentifier: String { get }
    
    var canEditing: Bool? { set get }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
    
    
}

public extension TableViewCompatible {
    var canEditing: Bool? {
        get {
            return false
        }
        set {
            
        }
    }
}

public protocol ModelConfigurable {
    
    associatedtype Model
    var model: Model? { get set }
    func configureWithModel(_: Model)
    
}

public protocol TableViewDataSourceCompatible: UITableViewDataSource {
    var sections: [TableViewSectionCompatible] { get set }
}

public extension TableViewDataSourceCompatible {
    func append(section: TableViewSectionCompatible) {
        sections.append(section)
    }
    
    func insert(row: TableViewCompatible, at indexPath: IndexPath) {
        sections[indexPath.section].insert(row, at: indexPath.row)
        
    }
    
    func removeRow(at indexPath: IndexPath) {
        sections[indexPath.section].remove(at: indexPath.row)
    }
    
    func replace(row: TableViewCompatible, at indexPath: IndexPath) {
        removeRow(at: indexPath)
        insert(row: row, at: indexPath)
        
        let range = indexPath.row..<indexPath.row
        sections[indexPath.section].rows.replaceSubrange(range, with: [row])
    }
}

public protocol TableViewSectionCompatible {
    
    var sortOrder: Int { get set }
    var rows: [TableViewCompatible] { get set }
    var headerTitle: String? { get set }
    var footerTitle: String? { get set }
    
}

public extension TableViewSectionCompatible {
    
    mutating func insert(_ row: TableViewCompatible, at index: Int) {
        rows.insert(row, at: index)
    }
    
    mutating func append(row: TableViewCompatible) {
        rows.append(row)
    }
    
    mutating func remove(at index: Int) {
        rows.remove(at: index)
    }
}

public struct TableViewSection: TableViewSectionCompatible {
    
    public var sortOrder: Int = 0
    public var rows: [TableViewCompatible]
    public var headerTitle: String?
    public var footerTitle: String?
    
    public init(rows: [TableViewCompatible]) {
        self.rows = rows
    }
    
}

public class TableViewDataSource: NSObject, TableViewDataSourceCompatible {
    
    
    public var sections: [TableViewSectionCompatible] = [] {
        didSet {
            sections.sort {
                $0.sortOrder < $1.sortOrder
            }
        }
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
        return model.cellForTableView(tableView: tableView, atIndexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerTitle
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let model = sections[indexPath.section].rows[indexPath.row]
        return model.canEditing ?? false
    }
}
