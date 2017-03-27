//
//  TableViewController.swift
//  GVanillaTableView
//
//  Created by Glenn Posadas on 3/28/17.
//  Copyright © 2017 Citus Labs. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    // MARK: - Properties
    
    lazy var data = [Data]()
    
    // MARK: - Functions
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom cell
        
        self.tableView.register(UINib(nibName: "GVanillaTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "GVanillaTableViewCell")
        
        // Load data!
        
        let imageService = ImageService()
        imageService.fetchImages(query: "Sports Car", page: 1) {
            [weak self] (baseData) in
            
            guard let strongSelf = self,
                let data = baseData?.data else { return }
            
            strongSelf.data = data
            strongSelf.tableView.reloadData()
        }
    }
}

// MARK: - TableView Delegates

extension TableViewController {
    
    // TODO: Add pagination
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
}

// MARK: - TableView Datasource

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GVanillaTableViewCell") as! GVanillaTableViewCell
        cell.data = self.data[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
}

