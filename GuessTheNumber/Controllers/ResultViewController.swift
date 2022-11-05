import UIKit

final class ResultViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var userNumberOfTriesLabel: UILabel!
    @IBOutlet weak var computerNumberOfTriesLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!

    @IBOutlet weak var mainMenuButton: UIButton!

    //MARK: - life cycle funcs
    override func viewDidLoad() {
        Manager.selectWinner()
        winnerSelected()
    }
    override func viewDidLayoutSubviews() {
        configure()
    }

    //MARK: - IBAction
    @IBAction func mainMenuButtonPressed(_ sender: UIButton) {
        popToRootViewController()
    }
}

private extension ResultViewController{

    //MARK: - flow funcs
    func configure () {
        mainMenuButton.titleLabel?.text = "Main menu"

        userNumberOfTriesLabel.textAlignment = .left
        computerNumberOfTriesLabel.textAlignment = .left
        winnerLabel.textAlignment = .center
    }

    func popToRootViewController() {
        Manager.setDefaultProperties()
        self.navigationController?.popToRootViewController(animated: false)
    }

    func winnerSelected() {
        if let userNumberOfTries = Manager.userNumberOfTries,
            let computerNumberOfTries = Manager.computerNumberOfTries {
            Manager.selectWinner()
            userNumberOfTriesLabel.text = "Your's tries count: \(userNumberOfTries)"
            computerNumberOfTriesLabel.text = "Computer's tries count: \(computerNumberOfTries)"
            winnerLabel.text = Manager.winner.rawValue
        }
    }
}
