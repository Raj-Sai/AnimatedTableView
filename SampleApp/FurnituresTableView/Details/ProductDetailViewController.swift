//
//  ProductDetailViewController.swift
//  SampleApp
//
//  Created by Amsaraj Mariappan on 23/7/2562 BE.
//  Copyright © 2562 Amsaraj. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
  
  var selectedCategory: Categories!
  
  let moreInfoText = "Select For More Info >"
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = selectedCategory.name
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 300
    
    NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.main) { [weak self] _ in
      self?.tableView.reloadData()
    }
  }
}

extension ProductDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selectedCategory.products.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductTableViewCell
    
    let work = selectedCategory.products[indexPath.row]
    
    cell.productTitleLabel.text = work.title
    cell.productImageView.image = work.image
    
    cell.productTitleLabel.backgroundColor = UIColor(white: 204/255, alpha: 1)
    cell.productTitleLabel.textAlignment = .center
    cell.moreInfoTextView.textColor = UIColor(white: 114 / 255, alpha: 1)
    cell.selectionStyle = .none
    
    cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
    cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
    
    cell.productTitleLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
    cell.moreInfoTextView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
    
    return cell
  }
}

extension ProductDetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? ProductTableViewCell else {
      return
    }
    
    var work = selectedCategory.products[indexPath.row]
    
    work.isExpanded = !work.isExpanded
    selectedCategory.products[indexPath.row] = work
    
    cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
    cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
    
    tableView.beginUpdates()
    tableView.endUpdates()
    
    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
  }
}


