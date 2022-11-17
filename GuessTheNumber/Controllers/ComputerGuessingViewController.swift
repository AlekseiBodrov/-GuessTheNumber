import UIKit

final class ComputerGuessingViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var numberOfAttemptsLabel: UILabel!
    @IBOutlet weak var nameGamerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var myNumberLabel: UILabel!

    @IBOutlet weak var moreButton: UIButton!

    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var lessButton: UIButton!

    //MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        configure ()
    }

    override func viewDidLayoutSubviews() {
        refreshView()
    }

    //MARK: - IBAction
    @IBAction func moreButtonPressed(_ sender: UIButton) {
        if Manager.userPickNumber > Manager.computerCurrentTry {
            checkValue(.more)
        } else {
            showAlert()
        }
    }

    @IBAction func equalButtonPressed(_ sender: UIButton) {
        if Manager.userPickNumber == Manager.computerCurrentTry {
            checkValue(.equal)
            Manager.selectWinner()
            presentViewController()
        } else {
            showAlert()
        }
    }

    @IBAction func lessButtonPressed(_ sender: UIButton) {
        if Manager.userPickNumber < Manager.computerCurrentTry {
            checkValue(.less)
        } else {
            showAlert()
        }
    }
}

private extension ComputerGuessingViewController{

    //MARK: - flow funcs
    func configure() {
        numberOfAttemptsLabel.textAlignment = .center
        nameGamerLabel.textAlignment = .center
        nameGamerLabel.text = "Computer is guessing".localized()
        questionLabel.textAlignment = .center
        myNumberLabel.text = "My number is ...".localized()
    }

    func refreshView() {
        guard let numberOfTries = Manager.computerNumberOfTries else { return }
        numberOfAttemptsLabel.text = "Try №".localized() + "\(numberOfTries)"
        if let computerCurrentTry = Manager.computerCurrentTry{
            questionLabel.text = "Your number is:".localized() + " \(String(describing: computerCurrentTry))?"
        }

        UIButton.configureButton(moreButton, label: ">")
        UIButton.configureButton(equalButton, label: "=")
        UIButton.configureButton(lessButton, label: "<")
    }

    func checkValue(_ button:Button) {
        Manager.checkNumber(button)
    }

    func presentViewController() {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "UserGuessingViewController") as? UserGuessingViewController else { return }
        self.navigationController?.pushViewController(controller, animated: false)
    }

    func showAlert() {
        let alert = UIAlertController(title: "Attention!".localized(),
                                      message: "I think , that It's not true.".localized(),
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
