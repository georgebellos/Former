//
//  RowFormer.swift
//  Former-Demo
//
//  Created by Ryo Aoyama on 7/23/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public protocol FormableRow {
    
    // Optional
    func configureWithRowFormer(rowFormer: RowFormer)
}

extension FormableRow {
    
    public func configureWithRowFormer(rowFormer: RowFormer) {}
}

public class RowFormer {
    
    public internal(set) final weak var cell: UITableViewCell? {
        didSet {
            self.cellConfigure()
        }
    }
    public internal(set) final weak var former: Former?
    public internal(set) final var indexPath: NSIndexPath?
    public internal(set) final var isTop: Bool = false
    public internal(set) final var isBottom: Bool = false
    
    public private(set) var cellType: UITableViewCell.Type
    public private(set) var registerType: Former.RegisterType
    public var selectedHandler: ((indexPath: NSIndexPath) -> ())?
    public var cellHeight: CGFloat = 44.0
    public var backgroundColor: UIColor?
    public var accessoryType: UITableViewCellAccessoryType?
    public var selectionStyle: UITableViewCellSelectionStyle?
    public var separatorColor: UIColor?
    
    public init<T: UITableViewCell where T: FormableRow>(
        cellType: T.Type,
        registerType: Former.RegisterType,
        selectedHandler: (NSIndexPath -> Void)? = nil) {
        
        self.cellType = cellType
        self.registerType = registerType
        self.selectedHandler = selectedHandler
    }
    
    public func cellConfigure() {
        
        self.cell?.backgroundColor =? self.backgroundColor
        self.cell?.selectionStyle =? self.selectionStyle
        self.cell?.accessoryType =? self.accessoryType
    }
    
    public func didSelectCell(indexPath: NSIndexPath) {
        
        self.selectedHandler?(indexPath: indexPath)
    }
}