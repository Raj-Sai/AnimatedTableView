//
//  Categories.swift
//  SampleApp
//
//  Created by Amsaraj Mariappan on 23/7/2562 BE.
//  Copyright © 2562 Amsaraj. All rights reserved.
//

import UIKit

struct Categories {
  let name: String
  let catType: String
  let image: UIImage
  var products: [Products]
  
  init(name: String, catType: String, image: UIImage, products: [Products]) {
    self.name = name
    self.catType = catType
    self.image = image
    self.products = products
  }
  
  static func categoriesFromBundle() -> [Categories] {
    
    var categories = [Categories]()
    
    guard let url = Bundle.main.url(forResource: "categories", withExtension: "json") else {
      return categories
    }
    
    do {
      let data = try Data(contentsOf: url)
      guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]  else {
        return categories
      }
      
      guard let categoryObjects = rootObject["Categories"] as? [[String: AnyObject]] else {
        return categories
      }
      
      for categoryObject in categoryObjects {
        if let name = categoryObject["name"] as? String,
          let type = categoryObject["catType"]  as? String,
          let imageName = categoryObject["image"] as? String,
          let image = UIImage(named: imageName),
          let productObject = categoryObject["products"] as? [[String : String]]{
          var products = [Products]()
          for productObject in productObject {
            if let proName = productObject["title"],
              let proImageName = productObject["image"],
              let proImage = UIImage(named: proImageName),
              let info = productObject["info"] {
              products.append(Products(title: proName,image: proImage,info: info, isExpanded: false))
            }
          }
          let category = Categories(name: name, catType: type, image: image, products: products)
          categories.append(category)
        }
      }
    } catch {
      return categories
    }
    
    return categories
  }
  
}
