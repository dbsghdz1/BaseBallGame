//
//  controller.swift
//  NumberBaseball
//
//  Created by 김윤홍 on 6/11/24.
//

class PlayBall {
    let msg = message()
    var systemNum = Number()
    //질문 초기화 부분
    init(systemNum: Number = Number()) {
        self.systemNum.number = generateSystem()
    }
    
    func gameStart() {
        var optionNumber = msg.selectOption()
        switch optionNumber {
        case "1":
            firstOption()
        case "2":
            secondOption()
            fallthrough
        case "3":
            print("종료합니다.")
        default:
            print("올바른 숫자를 입력해주세요!")
            optionNumber = msg.selectOption()
        }
    }
    
    func firstOption() {
        msg.startMessage()
        var i = 0
        while true {
            var userNum = msg.inputMessage()
            while !checkInput(userNum) {
                userNum = msg.inputMessage()
            }
            let userNumber = userNum.map({ Int(String($0))! })
            if playBall(systemNum.number, userNumber) == "정답입니다!" {
                print("정답입니다!")
                systemNum.gameRecord.append(i)
                gameStart()
            } else {
                print(playBall(systemNum.number, userNumber))
            }
            i += 1
        }
    }
    
    func secondOption() {
        print("< 게임 기록 보기 >")
        for (i, j) in systemNum.gameRecord.enumerated() {
            print("\(i + 1)번째 게임 : 시도횟수 - \(j)")
        }
    }
    
    func checkInput(_ input: String) -> Bool {
        if input.count != 3 {
            print("올바르지 않은 입력값입니다.")
            return false
        }
        if Set(input).count != input.count {
            print("올바르지 않은 입력값입니다.")
            return false
        }
        
        if Int(input) != nil {
        } else {
            print("올바르지 않은 입력값입니다.")
            return false
        }
        let arrInput = Array(input)
        if arrInput[0] == "0" {
            print("올바르지 않은 입력값입니다.")
            return false
        }
        return true
    }
    
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
    
    func generateSystem() -> [Int]{
        var number = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        let noZeroArr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        var system:[Int] = []
        for i in 0...2 {
            if i == 0 {
                if let randNum = noZeroArr.randomElement() {
                    system.append(randNum)
                    number.remove(at: number.firstIndex(of: randNum)!)
                }
            } else {
                if let randNum = number.randomElement() {
                    system.append(randNum)
                    number.remove(at: number.firstIndex(of: randNum)!)
                }
            }
        }
        return system
    }
}
