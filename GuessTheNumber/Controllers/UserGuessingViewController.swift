import UIKit

class UserGuessingViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var enterNumberTextField: UITextField!
    @IBOutlet weak var numberOfTriesLabel: UILabel!
    @IBOutlet weak var nameGamerLabel: UILabel!
    @IBOutlet weak var labelMyNumberIs: UILabel!
    @IBOutlet weak var enterNumberButton: UIButton!

    //MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addTapGestureRecognizer()
        print(Manager.computerPickNumber)
    }
    
    override func viewDidLayoutSubviews() {
        refreshView()
    }

    //MARK: - IBAction
    @IBAction func enterNumberButton(_ sender: UIButton) {
        checkValue()
    }

    @objc func tapGestureDetected () {
        enterNumberTextField.resignFirstResponder()
    }
}

private extension UserGuessingViewController{

    //MARK: - flow funcs
    func configure() {
        labelMyNumberIs.text = "My number is ..."
        numberOfTriesLabel.textAlignment = .center
        nameGamerLabel.textAlignment = .center
        nameGamerLabel.text = "You are guessing"
        labelMyNumberIs.textAlignment = .center

        enterNumberTextField.becomeFirstResponder()

        enterNumberTextField.returnKeyType = UIReturnKeyType.done
        enterNumberTextField.keyboardType = UIKeyboardType.numberPad
    }

    func refreshView() {
        enterNumberButton.titleLabel?.text = "Enter The Number"
        guard let numberOfTries = Manager.userNumberOfTries else { return }
        numberOfTriesLabel.text = "Try №\(numberOfTries)"
    }

    func checkValue() {

        Manager.userNumberOfTries += 1

        guard let text = enterNumberTextField.text else { return }
        guard let textInt = Int(text), textInt <= 100 && textInt >= 0 else {
            showAlert()
            return
        }

        Manager.userCurrentTryGuess = textInt
        print(textInt)

        if Manager.computerPickNumber < Manager.userCurrentTryGuess {
            labelMyNumberIs.text = "My number is less than yours"
            print("<")
        } else if Manager.computerPickNumber == Manager.userCurrentTryGuess {
            presentViewController()
        } else if Manager.computerPickNumber > Manager.userCurrentTryGuess {
            labelMyNumberIs.text = "My number is more than yours"
            print(">")
        }

    }

    func presentViewController() {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else { return }
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    func addTapGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureDetected))
        self.view.addGestureRecognizer(recognizer)
    }

    func showAlert() {
        let alert = UIAlertController(title: "Attention!", message: "Enter the number \n0...100", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

