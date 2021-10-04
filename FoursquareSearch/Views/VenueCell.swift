//
//  VenueCell.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import UIKit

class VenueCell: UITableViewCell {

    static let reuseId = "VenueCell"
    private var distanceLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(venue: Venue) {
        textLabel?.text = venue.name
        detailTextLabel?.text = venue.address.first
        
        let distanceInKm = convertDistanceToKm(distance: venue.distance)
        distanceLabel.text = "\(distanceInKm) km"
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        distanceLabel = UILabel(frame: CGRect(x: 5, y: 5, width: 80, height: 20))

        distanceLabel.numberOfLines = 0
        distanceLabel.textColor = .systemGray
        accessoryView = distanceLabel
    }
    
    private func convertDistanceToKm(distance: Int) -> Double {
        let distanceM = Measurement(value: Double(distance), unit: UnitLength.meters)
        
        return distanceM.converted(to: UnitLength.kilometers).value
    }
}
