//
//  controller.swift
//  NumberBaseball
//
//  Created by 김윤홍 on 6/11/24.
//

protocol MessageProtocol {
    func selectOption() -> String
    func showStartMessage()
    func promptUserInput() -> String
    func showIncorrectInputMessage()
    func showCorrectMessage()
    func showNothingMessage()
    func showFinishMessage()
    func showRecords()
    func recordAttempt(gameNumber: Int, attemptCount: Int)
}

class PlayBall {
    let messageHandler: MessageProtocol
    var numberSystem: Number
    let inputValidator: InputValidator
    let randomNumberGenerator: RandomNumberGenerator
    
    init(messageHandler: MessageProtocol, numberSystem: Number, inputValidator: InputValidator, randomNumberGenerator: RandomNumberGenerator) {
        self.messageHandler = messageHandler
        self.numberSystem = numberSystem
        self.inputValidator = inputValidator
        self.randomNumberGenerator = randomNumberGenerator
        self.numberSystem.number = randomNumberGenerator.generateSystem()
    }
    
    func gameStart() {
        var shouldContinue = true
        
        while shouldContinue {
            let selectedOption = messageHandler.selectOption()
            numberSystem.number = randomNumberGenerator.generateSystem()
            switch selectedOption {
            case "1":
                startFirstOption()
            case "2":
                startSecondOption()
            case "3":
                messageHandler.showFinishMessage()
                shouldContinue = false
            default:
                messageHandler.showIncorrectInputMessage()
            }
        }
    }
    
    func startFirstOption() {
        messageHandler.showStartMessage()
        var attemptCount = 0
        var isCorrect = true
        while isCorrect {
            var userInput = messageHandler.promptUserInput()
            while !inputValidator.validateInput(userInput) {
                userInput = messageHandler.promptUserInput()
            }
            let userNumbers = userInput.map({ Int(String($0))! })
            let gameResult = checkBallCount(systemNumbers: numberSystem.number, userNumbers: userNumbers)
            if gameResult == "정답입니다!" {
                print(gameResult)
                numberSystem.gameRecord.append(attemptCount + 1)
                isCorrect = false
            } else {
                print(gameResult)
            }
            attemptCount += 1
        }
    }
    
    func startSecondOption() {
        messageHandler.showRecords()
        for (index, attempts) in numberSystem.gameRecord.enumerated() {
            messageHandler.recordAttempt(gameNumber: index + 1, attemptCount: attempts)
        }
    }
    
    func checkBallCount(systemNumbers: [Int], userNumbers: [Int]) -> String {
        var strikeCount = 0
        var ballCount = 0
        
        for i in 0..<systemNumbers.count {
            if systemNumbers[i] == userNumbers[i] {
                strikeCount += 1
            } else if systemNumbers.contains(userNumbers[i]) {
                ballCount += 1
            }
        }

        if strikeCount == 3 {
            return "정답입니다!"
        } else if strikeCount == 0 && ballCount == 0 {
            return "Nothing"
        }
        
        return "\(strikeCount)스트라이크 \(ballCount)볼"
    }
}

// 랜덤 숫자 생성
class RandomNumberGenerator {
    func generateSystem() -> [Int] {
        var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
        numbers.shuffle()
        
        if numbers.first == 0 {
            numbers.swapAt(0, 1)
        }
        return Array(numbers.prefix(3))
    }
}

class InputValidator {
    let messageHandler: MessageProtocol = Message()
    enum ValidationError: Error {
        case invalidInput
    }
    
    func validateInput(_ input: String) -> Bool {
        do {
            return try checkInput(input)
        } catch {
            return false
        }
    }

    func checkInput(_ input: String) throws -> Bool {
        let isValid = input.count == 3 && input.count == Set(input).count && Int(input) != nil
        if !isValid {
            messageHandler.showIncorrectInputMessage()
            throw ValidationError.invalidInput
        }
        return true
    }
    
    func testCheckInput(_ input: String) -> Bool {
        do {
            let result = try checkInput(input)
            print("Result is \(result)")
            return result
        } catch ValidationError.invalidInput {
            print("error")
            return false
        } catch {
            print("An error occurred: \(error)")
            return false
        }
    }
}

