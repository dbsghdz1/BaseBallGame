# nbcamp-Project-BaseBallGame
[내일배움캠프 3주차과제(5조 김윤홍)-숫자야구게임
<br><br><br><br>

##
프로젝트소개
"숫자야구게임"프로젝트<p> 이 프로젝트는 Swift언어를 사용하여 Xcode에서 개발한 Command-LineTooL 애플리케이션입니다.br>
사용자들은 콘솔창을 통해서 숫자야구 게임을 즐길수 있습니다.
<br><br>

##
개발기간 
*2024-06-11(월)~2024-06-17(금),5일간

##
프로젝트 실행방법

<img width="487" alt="스크린샷 2024-06-17 10 13 20" src="https://github.com/dbsghdz1/BaseBallGame/assets/114382668/abef84e6-1125-48b8-9eb9-2f1843f8933a">

##
main파일 - 인스턴스 생성후 게임 start

##
view파일 - 메시지 다루는 클래스 생성

##
data파일 - 게임 데이터를 보관하는 struct

##
controller파일 
class PlayBall 내 함수

func gameStart - 게임 시작부분 사용자의 입력을 받아서 1,2,3번 옵션을 구분한 후 해당하는 함수 실행

func startFirstOption - 사용자의 연속된 숫자 3개를 받아서 결과를 출력하는 함수 입력실패시 while문안에서 반복하고 게임기록 저장.

func startSecondOption - 저장된 게임 기록 출력 부분

checkBallCount - strike, ball 카운트 계산후 결과 리턴
<br><br><br><br>

class RandomNumberGenerator 내 함수

func generateSystem - 시스템이 랜덤번호 생성
<br><br><br><br>

class InputValidator 내 함수

func validateInput - 입력값을 checkInput으로 확인

func checkInput - 입력값을 검사하고 에러시 throw 재대로된 입력시 true 

func testCheckInput - do catch문 으로 에러 실행
