## https://colab.research.google.com/drive/1Rb_Xnd5F07Yn91hYrgnfRZsr3exgcTUj?usp=sharing
## rock paper scissors

game <- function() {
  tie <- 0
  lose <- 0
  win <- 0

while (TRUE) {
  answer <- c("rock", "paper", "scissors")
  input_user <- readline("you choose (rock, paper, scissors) or type quit to exit the game: ")
  bot_computer <- sample(answer, 1)
  
  if(input_user == "rock" & bot_computer == "rock") {
    message("TIE!")
    tie <- tie + 1
  } else if(input_user == "rock" & bot_computer == "paper") {
    message("LOESS! bot answer paper")
    lose <- lose + 1
  } else if(input_user == "rock" & bot_computer == "scissors") {
    message("WIN! bot answer scissors")
    win <- win + 1
  } else if(input_user == "paper" & bot_computer == "rock") {
    message("WIN! bot answer scissors")
    win <- win + 1
  } else if(input_user == "paper" & bot_computer == "paper") {
    message("TIE!")
    tie <- tie + 1
  } else if(input_user == "paper" & bot_computer == "scissors") {
    message("LOESS! bot answer paper")
    lose <- lose + 1
  } else if(input_user == "scissors" & bot_computer == "rock") {
    message("LOESS! bot answer paper")
    lose <- lose + 1
  } else if(input_user == "scissors" & bot_computer == "paper") {
    message("WIN! bot answer scissors")
    win <- win + 1
  } else if(input_user == "scissors" & bot_computer == "scissors") {
    message("TIE!")
    tie <- tie + 1
  } else if(input_user == "quit") {
    message("exit the game")
    message(paste("WIN = ", win))
    message(paste("TIE = ", tie))
    message(paste("LOSE = ",lose))
    break
  } else {
    print("please! type rock paper and scissors")
  }
}
}  
