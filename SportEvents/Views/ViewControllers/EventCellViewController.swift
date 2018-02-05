//
//  EventCellViewController.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import UIKit

class EventCellViewController: UITableViewCell {

    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    var eventId: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setupCell(event: Event, timeFrame: String, participants: String? = nil){
        eventId = "\(event.eventId)"
        eventNameLabel.text = event.eventName
        timeLabel.text = timeFrame
        timeLabel.sizeToFit()
        locationLabel.text = event.location
        if let forum = participants {
            participantsLabel.text = forum
        }
    }
}
