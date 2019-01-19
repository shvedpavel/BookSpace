//
//  Book.swift
//  test
//
//  Created by Apple on 11/01/2019.
//  Copyright © 2019 shved. All rights reserved.
//

import Foundation
import FolioReaderKit

struct Book {
    var name: String
    var bookPath: String!
    var readerIdentifier: String
    var shouldHideNavigationOnTap: Bool = true
    var scrollDirection: FolioReaderScrollDirection = .vertical
}

