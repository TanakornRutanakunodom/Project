## https://colab.research.google.com/drive/1bkUk9R0KZJt4zFKID94lmc4SGuhl_D9A#scrollTo=Hk590HG9-TFt
## rock paper scissors
import random

def game():
    tie = 0
    lose = 0
    win = 0
    while True:
        answer = ['rock', 'paper', 'scissors']
        input_user = input("you choose (rock, paper, scissors) or type quit to exit the game: ").lower()
        bot_computer = random.choice(answer)
        if input_user == "rock" and bot_computer == "rock":
            print("Tie! bot answer rock")
            tie = tie + 1
        elif input_user == "rock" and bot_computer == "scissors":
            print("Win! bot answer scissors")
            win = win + 1
        elif input_user == "rock" and bot_computer == "paper":
            print("Lose! bot answer paper")
            lose = lose+ 1
        elif input_user == "paper" and bot_computer == "rock":
            print("Win! bot answer rock")
            win = win + 1
        elif input_user == "paper" and bot_computer == "scissors":
            print("Lose! bot answer scissors")
            lose = lose + 1
        elif input_user == "paper" and bot_computer == "paper":
            print("Tie!  bot answer paper")
            tie = tie + 1    
        elif input_user == "scissors" and bot_computer == "paper":
            print("Win! bot answer paper")
            win = win + 1
        elif input_user == "scissors" and bot_computer == "rock":
            print("Lose! bot answer rock")
            lose = lose + 1
        elif input_user == "scissors" and bot_computer == "scissors":
            print("Tie! bot answer scissors")
            tie = tie + 1      
        elif input_user == "qult":
            print("exit the game")
            print(f" Win : {win}, Tie : {tie}, Lose : {lose}")
            break
        else:
            print("please try again")
