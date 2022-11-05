import UIKit

final class PickANumberViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var enterNumberButton: UIButton!

    //MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidLayoutSubviews() {
        configure()
    }

    //MARK: - IBAction
    @IBAction func enterNumberButton(_ sender: UIButton) {
        setNumber()
    }

    @objc func tapGestureDetected () {
        numberTextField.resignFirstResponder()
    }
}

private extension PickANumberViewController{

    //MARK: - flow funcs
    func configure() {
        enterNumberButton.titleLabel?.text = "Enter The Number"

        numberTextField.becomeFirstResponder()

        numberTextField.returnKeyType = UIReturnKeyType.done
        numberTextField.keyboardType = UIKeyboardType.numberPad
        numberTextField.placeholder = "Guess the number 0...100"
        numberTextField.textAlignment = .center

        addTapGestureRecognizer()
    }

    func setNumber() {
        guard let text = numberTextField.text else { return }
        guard let textInt = Int(text), textInt <= 100 && textInt >= 0 else {
            showAlert()
            return
        }
            Manager.userPickNumber = textInt
            presentViewController()
    }

    func presentViewController() {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ComputerGuessingViewController") as? ComputerGuessingViewController else { return }
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
