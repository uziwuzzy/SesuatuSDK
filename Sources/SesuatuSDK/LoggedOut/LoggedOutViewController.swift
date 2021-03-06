//
//  Copyright (c) 2018. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
import RxCocoa
import SnapKit
import UIKit
import RxSwift

class LoggedOutViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    init(mutablePlayersStream: MutablePlayersStream, boringRepository: BoringRepository) {
        self.mutablePlayersStream = mutablePlayersStream
        self.boringRepository = boringRepository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let playerFields = buildPlayerFields()
        buildLoginButton(withPlayer1Field: playerFields.player1Field, player2Field: playerFields.player2Field)
        buildBoringButton()
    }

    // MARK: - Private

    private let mutablePlayersStream: MutablePlayersStream
    private let boringRepository: BoringRepository
    private var player1Field: UITextField?
    private var player2Field: UITextField?
    
    private var loginButton: UIButton?

    private func buildPlayerFields() -> (player1Field: UITextField, player2Field: UITextField) {
        let player1Field = UITextField()
        self.player1Field = player1Field
        player1Field.borderStyle = UITextField.BorderStyle.line
        view.addSubview(player1Field)
        player1Field.placeholder = "Player 1 name"
        player1Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(100)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(40)
        }

        let player2Field = UITextField()
        self.player2Field = player2Field
        player2Field.borderStyle = UITextField.BorderStyle.line
        view.addSubview(player2Field)
        player2Field.placeholder = "Player 2 name"
        player2Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player1Field.snp.bottom).offset(20)
            maker.left.right.height.equalTo(player1Field)
        }

        return (player1Field, player2Field)
    }

    private func buildLoginButton(withPlayer1Field player1Field: UITextField, player2Field: UITextField) {
        let loginButton = UIButton()
        self.loginButton = loginButton
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player2Field.snp.bottom).offset(20)
            maker.left.right.height.equalTo(player1Field)
        }

        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor.black
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    private func buildBoringButton() {
        let boringButton = UIButton()
        view.addSubview(boringButton)
        boringButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(loginButton!.snp.bottom).offset(20)
            maker.left.right.height.equalTo(loginButton!)
        }

        boringButton.setTitle("Boring", for: .normal)
        boringButton.setTitleColor(UIColor.white, for: .normal)
        boringButton.backgroundColor = UIColor.black
//        boringButton.addTarget(self, action: #selector(didTapBoringButton), for: .touchUpInside)
        boringButton.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else {return}
                self.didTapBoringButton()
            })
            .disposed(by: disposeBag)
    }

    @objc
    private func didTapLoginButton() {
        guard let player1Field = player1Field, let player2Field = player2Field else {
            return
        }
        mutablePlayersStream.update(player1: player1Field.text, player2: player2Field.text)
    }
    
    @objc
    private func didTapBoringButton() {
        boringRepository.getBoringActivity()
            .observe(on: MainScheduler())
            .subscribe(onSuccess: { [weak self] boringActivity in
                guard let self = self else {return}
                self.player1Field?.text = boringActivity.activity
                self.player2Field?.text = boringActivity.type
            }, onFailure: { error in
                
            }
            )
            .disposed(by: disposeBag)

    }
}
