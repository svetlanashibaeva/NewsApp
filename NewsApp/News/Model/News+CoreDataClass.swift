//
//  News+CoreDataClass.swift
//  
//
//  Created by Света Шибаева on 23.05.2021.
//
//

import Foundation
import CoreData

@objc(News)
public class News: NSManagedObject {

    static func create(with article: Article, context: NSManagedObjectContext) {
        let news = News(context: context)
        
//        news... = ..
//
//            context.save()
        
        news.title = article.title
        news.descr = article.description
        news.urlToImage = article.urlToImage
        news.url = article.url
//        newsObject.publishedAt = arcticle.publishedAt  преобразовать из стринга в дату
        
    }
}
