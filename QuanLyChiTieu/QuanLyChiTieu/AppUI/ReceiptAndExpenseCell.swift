//
//  ReceiptAndExpenseCell.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class ReceiptAndExpenseCell: UITableViewCell {

    @IBOutlet weak var lbIncomeColumn: UILabel!
    @IBOutlet weak var lbExpenseColumn: UILabel!
    @IBOutlet weak var lbIconIncome: UILabel!
    @IBOutlet weak var lbIconExpense: UILabel!
    @IBOutlet weak var lbIncome: UILabel!
    @IBOutlet weak var lbExpense: UILabel!
    @IBOutlet weak var lbIncomeMoney: UILabel!
    @IBOutlet weak var lbExpenseMoney: UILabel!
    @IBOutlet weak var lbSepa: UILabel!
    @IBOutlet weak var lbAccumulate: UILabel!
    @IBOutlet weak var lbNoData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbIncome.text = NSLocalizedString("Income", comment: "")
        lbExpense.text = NSLocalizedString("Expense", comment: "")
        lbAccumulate.text = NSLocalizedString("Accumulate", comment: "")
        
        lbNoData.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        lbNoData.backgroundColor = UIColor.white
        lbNoData.textColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        lbNoData.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left()?.bottom()?.right()?.equalTo()(self)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
