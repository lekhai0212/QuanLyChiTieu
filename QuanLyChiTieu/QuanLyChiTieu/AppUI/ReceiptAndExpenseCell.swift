//
//  ReceiptAndExpenseCell.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbIncome.text = NSLocalizedString("Income", comment: "")
        lbExpense.text = NSLocalizedString("Expense", comment: "")
        lbAccumulate.text = NSLocalizedString("Accumulate", comment: "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
