//
//  main.swift
//  NBO
//
//  Created by 김윤홍 on 6/11/24.
//

import Foundation
print("< 게임을 시작합니다 > \n 숫자를 입력하세요")
var playOn = true
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

while (playOn) {
    let input = readLine()!
    if !checkInput(input) {
        break
    }
    let user = input.map({ Int(String($0))! })
    print(playBall(system, user))
    if playBall(system, user) == "정답입니다!" {
        break
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
