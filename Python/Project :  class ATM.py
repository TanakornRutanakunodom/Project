class ATM:
    def __init__(self, name, account_number, balance, pin):
        self.name = name
        self.account_number = account_number
        self.balance = balance
        self.pin = pin

    def __str__(self):
        return "welcome to ATM "

    def log_in(self):
        count = 0
        while (count < 3):
            input1 = input("Your pin :")
            if input1 == self.pin:
                print("log in successfully")
                break
            else:
                print("please try again")
            count = count + 1
        
    def account_detail(self):
        print(f"""
        --------------Account Detail-------------------\n
        Account Holder : {self.name}. \n
        Account Number : {self.account_number}. \n
        Available Balance : {self.balance} Bath """)

    def deposit(self, amount):
        self.amount = amount
        self.balance = self.balance + self.amount
        print(f"Your balance {self.balance} bath.")


    def withdraw(self, amount):
        self.amount = amount
        if amount > self.balance:
            print("""
            Faild to withdraw\n
            Your balance not enough""")
        else:
            self.balance = self.balance - self.amount
            print(f"""
            {amount} withdraw sucessfully. \n
            Your balance {self.balance} bath.""")
        
    def check_balance(self):
        print(f"Available balance {self.balance}")

    def transaction(self):
        print("""
        -------------Menu------------------\n
        1) Account Detail\n
        2) deposit\n
        3) withdraw\n
        4) check balance\n
        5) exit """)
        while True:
            option = int(input("enter 1, 2, 3,4 or 5:"))
            if option == 1:
                self.account_detail()
            elif option == 2:
                amount = int(input("How much you want to deposit: "))
                self.deposit(amount)
            elif option == 3:
                amount = int(input("How much you want to withdraw: "))
                self.withdraw(amount)
            elif option == 4:
                self.check_balance()
            elif option == 5:
                print("exit")
                break  
            else:
                print("error enter 1, 2, 3, 4 or 5 only!")
        while True:
            tansaction = input("Do you want to any tansaction? (y/n) : ")
            if tansaction == "y":
                 self.transaction()
            elif tansaction == "n":
                 print("Thank you for using the service")
                 break
            else:
             print("please try again")   

atm1 = ATM("Tanakorn Rutanakunodom", "123-1332-424",  5000, "1234")
atm2 = ATM("monkey D luffy", "555-5555-555",  3000000000, "5555")

print(atm1)
atm1.log_in()
atm1.account_detail()
atm1.deposit(500)
atm1.check_balance()
atm2.transaction()
