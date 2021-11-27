//
//  BooksListCell.swift
//  Test2
//
//  Created by Stas Kirichok on 16.11.2021.
//

import UIKit

class BookListCell: UITableViewCell {
    static let id = String(describing: BookListCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .gray
    }
    
    func configure(with model: Book) {
        titleLabel.text = model.title
        publishedDateLabel.text = model.publishedDate
    }
}
