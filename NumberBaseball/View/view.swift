//
//  view.swift
//  NumberBaseball
//
//  Created by 김윤홍 on 6/11/24.
//

import Foundation

class message {
    func startMessage() {
        print("< 게임을 시작합니다 > \n 숫자를 입력하세요")
    }
    
    func inputMessage() -> String {
        let msg = readLine()!
        return msg
    }
    
    func selectOption() -> String {
        print("환영합니다! 원하시는 번호를 입력해주세요")
        print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
        let option = readLine()!
        return option
    }
}
