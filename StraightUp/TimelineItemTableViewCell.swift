//
//  TimelineItemTableViewCell.swift
//  StraightUp
//
//  Created by Timothy DenOuden on 12/16/17.
//  Copyright © 2017 Timothy DenOuden. All rights reserved.
//

import UIKit

class TimelineItemTableViewCell: UITableViewCell {
    public static let REUSE_IDENTIFIER = "TimelineItemTableViewCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layer = CAShapeLayer()
        let parentRect = self.contentView.frame.insetBy(dx: 8, dy: 8)
        layer.frame = CGRect(x: parentRect.minX, y: parentRect.minY, width: (parentRect.width / 2) + 30, height: parentRect.height) 
        layer.backgroundColor = UIColor.green.cgColor
        layer.cornerRadius = 16
        self.contentView.layer.sublayers?.insert(layer, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func set(timelineItem: TimelineItem) {
        leftLabel.text = timelineItem.message
        rightLabel.text = timelineItem.getDateAsString()
    }
}
