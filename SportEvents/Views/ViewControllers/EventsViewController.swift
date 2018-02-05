//
//  ViewController.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/2/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    @IBOutlet weak var eventsTable: UITableView!
    @IBOutlet weak var topBar: UINavigationItem!
    var presenter: EventsPresenter!
    let cellIdentifier = "EventCell"
    let kSegueToDetailIdentifier = "segueToEventDetail"
    let kSegueToAddEventIdentifier = "segueToAddEvent"
    var selectedEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Navigation
    
    @IBAction func goToAddEvent(_ sender: Any) {
        
        self.performSegue(withIdentifier: self.kSegueToAddEventIdentifier, sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueToDetailIdentifier {
            if let event = selectedEvent {
                let detailController = segue.destination as! EventDetailViewController
                detailController.loadPresenter(event: event)
            }
        } else if segue.identifier == kSegueToAddEventIdentifier {
            let addEventController = segue.destination as! AddEventViewController
            addEventController.loadPresenter(lastEventId: presenter.getLastEventId())
        }
    }
    //MARK: - Methods
    
    func loadPresenter () {
        if presenter == nil {
            presenter = EventsPresenter(locator: EventsUseCaseLocator.defaultLocator)
        }
    }
}
// MARK: -
extension EventsViewController {
    func configureUI() {
        
        guard (self.presenter) != nil else {
            return
        }
        topBar.title = "SPORTS_EVENTS".localized()
        LoaderView.show(view: self.view)
        presenter.loadEvents { [weak self] (response) in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                LoaderView.dismiss()
                switch response {
                case .success(let events):
                    guard let events = events else { return }
                    if events.count == 0 {
                        strongSelf.presentAlert(message: strongSelf.presenter.emptyDataMessage,
                                                type: AlertType.regular)
                        return
                    }
                    strongSelf.eventsTable.reloadData()
                    
                case .failure:
                    strongSelf.presentAlert(message: strongSelf.presenter.emptyDataMessage,
                                            type: AlertType.regular)
                case .notConnectedToInternet:
                    strongSelf.presentAlert(message: strongSelf.presenter.emptyDataMessage,
                                            type: AlertType.regular)
                    
                }
            }
        }
    }
}

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.retrieveDates().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let days = presenter.retrieveDates()
        if section < days.count {
            return presenter.cuantityOfRowsPer(date: days[section])
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventCellViewController
        guard let event = presenter.getEventFor(indexPath: indexPath) else { return cell }
        let timeFrame = presenter.getTimeFrame(For: event)
        let participants = presenter.getParticipantsText(For: event)
        cell.setupCell(event: event, timeFrame: timeFrame, participants: participants)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.getTitleFor(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EventCellViewController
        if let event = presenter.getEventForId(eventId: cell.eventId) {
            selectedEvent = event
            self.performSegue(withIdentifier: self.kSegueToDetailIdentifier, sender: self)
        }
        
    }
}
