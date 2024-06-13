//
//  controller.swift
//  NumberBaseball
//
//  Created by 김윤홍 on 6/11/24.
//

protocol MessageProtocol {
    func selectOption() -> String
    func startMessage()
    func inputMessage() -> String
    func incorrect()
    func correct()
    func nothing()
    func finish()
    func showRecord()
    func record()
}

// Class for handling the game logic
class PlayBall {
    let msg: MessageProtocol
    var systemNum: Number
    let checkInput: CheckInputMessage
    let makeRandom: GenerateRandomNumber
    
    init(msg: MessageProtocol, systemNum: Number, checkInput: CheckInputMessage, makeRandom: GenerateRandomNumber) {
        self.msg = msg
        self.systemNum = systemNum
        self.checkInput = checkInput
        self.makeRandom = makeRandom
        self.systemNum.number = makeRandom.generateSystem()
    }
    
    func gameStart() {
        let optionNumber = msg.selectOption()
        systemNum.number = [1,2,3]
        switch optionNumber {
        case "1":
            firstOption()
        case "2":
            secondOption()
        case "3":
            msg.finish()
            return
        default:
            print("올바른 숫자를 입력해주세요!")
            gameStart()
        }
    }
    
    // 1번옵션 1번 로직 이상함 while 문부터
    func firstOption() {
        msg.startMessage()
        var i = 0
        while true {
            var userNum = msg.inputMessage() //메시지 입력 받기
            while !checkInput.checkInput(userNum) {
                userNum = msg.inputMessage()
            }
            let userNumber = userNum.map({ Int(String($0))! })
            let result = playBall(systemNum.number, userNumber)
            if result == "정답입니다!" {
                print(result)
                systemNum.gameRecord.append(i + 1)
                gameStart()
            } else {
                print(result)
            }
            i += 1
        }
    }
    
    // 2번 옵션
    func secondOption() {
        msg.showRecord()
        for (i, j) in systemNum.gameRecord.enumerated() {
            msg.record()
            print("\(i + 1)번째 게임 : 시도횟수 - \(j)")
        }
        gameStart()
    }
    
    // 스트라이크 볼 확인 로직
    func playBall(_ system: [Int], _ user: [Int]) -> String {
        var strike = 0
        var ball = 0
        for i in 0...2 {
            for j in 0...2 {
                if (system[i] == user[j] && i == j) {
                    strike += 1
                } else if (system[i] == user[j] && i != j) {
                    ball += 1
                }
            }
        }
        if strike == 3 {
            return "정답입니다!"
        } else if (strike == 0 && ball == 0) {
            return "Nothing"
        }
        return "\(strike)스트라이크 \(ball)볼"
    }
}

// 랜덤 숫자 생성
class GenerateRandomNumber {
    func generateSystem() -> [Int]{
        var addZero = true
        var number = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        var system:[Int] = []
        for _ in 0...2 {
            if let randNum = number.randomElement() {
                system.append(randNum)
                number.removeAll { $0 == randNum }
            }
            if addZero {
                number.append(0)
                addZero = false
            }
        }
        return system
    }
}


// 입력값이 올바른지 확인
class CheckInputMessage {
    let msg = Message()
    func checkInput(_ input: String) -> Bool {
        let isValid = input.count != 3 || input.count != Set(input).count || Int(input) == nil
        if isValid {
            msg.incorrect()
            return false
        }
        let arrInput = Array(input)
        if arrInput[0] == "0" {
            msg.incorrect()
            return false
        }
        return true
    }
}
