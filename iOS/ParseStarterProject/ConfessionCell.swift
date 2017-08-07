//
//  ConfessionCell.swift
//  Confessions
//
//  Created by Kirill Kudaev on 7/15/17.
//

import UIKit

class ConfessionCell: UITableViewCell {
    
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet weak var lblLikesNumber: UILabel!
    @IBOutlet weak var lblYesNumber: UILabel!
    @IBOutlet weak var lblNoNumber: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet weak var btnLike: UIButton!
}
