//
//  Products.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//


import Foundation

// MARK: - ProductsModelElement
struct ProductsModel: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let productsModelDescription: String?
    let category: Category?
    let image: String?
    let rating: Rating?
    
    init() {
        self.id = nil
        self.title = nil
        self.price = nil
        self.productsModelDescription = nil
        self.category = nil
        self.image = nil
        self.rating = nil
    }

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case productsModelDescription = "description"
        case category, image, rating
    }
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}


