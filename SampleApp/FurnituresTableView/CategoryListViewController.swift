//
//  CategoryListViewController.swift
//  SampleApp
//
//  Created by Amsaraj Mariappan on 23/7/2562 BE.
//  Copyright © 2562 Amsaraj. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController {
  
  let categories = Categories.categoriesFromBundle()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 140
    
    NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.main) { [weak self] _ in
      self?.tableView.reloadData()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? ProductDetailViewController,
        let indexPath = tableView.indexPathForSelectedRow {
      destination.selectedCategory = categories[indexPath.row]
    }
  }
}

extension CategoryListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CategoryTableViewCell
    
    let category = categories[indexPath.row]
    
    cell.typeLabel.text = category.catType
    cell.typeLabel.textColor = UIColor(white: 114/255, alpha: 1)
    
    cell.categoryImageView.image = category.image
    cell.nameLabel.text = category.name
    
    cell.nameLabel.backgroundColor = UIColor(red: 1, green: 152 / 255, blue: 0, alpha: 1)
    cell.nameLabel.textColor = UIColor.white
    cell.nameLabel.textAlignment = .center
    cell.selectionStyle = .none
    
    cell.nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    cell.typeLabel.font = UIFont.preferredFont(forTextStyle: .body)
    
    return cell
  }
}

