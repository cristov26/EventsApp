//
//  EventDetailViewController.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/4/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet weak var barView: UINavigationItem!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    var presenter: EventDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPresenter (event: Event) {
        presenter = EventDetailPresenter.init(event: event)
    }
}

//MARK: -
private extension EventDetailViewController {
    func configureUI(){
        guard (self.presenter) != nil else {
            return
        }
        detailLabel.text = presenter.event.eventDescription
        startLabel.text = presenter.getFormattedTime(by: presenter.event.initialDate)
        if let endDate = presenter.event.endDate {
            endsLabel.text = presenter.getFormattedTime(by: endDate)
        }
        if let location = presenter.event.location {
            locationLabel.text = location
        }
        if let participants = presenter.event.forum {
            participantsLabel.text = "\(participants)"
        }
        barView.title = presenter.event.eventName
    }
}
