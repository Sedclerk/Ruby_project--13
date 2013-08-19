require "mysql"

class Account
    
    attr_accessor :account_holder, :balance
    
    def initialize(account_holder)
        @account_holder = account_holder
        
        @db = Mysql.new 'localhost', 'root', 'Sedclerk13', 'tsiky'
        st = @db.query("INSERT INTO accounts(name, balance) VALUES ( '#{account_holder}' , 0)")
    end
    
    def balance
        bal = 0
        st = @db.query("SELECT balance FROM accounts WHERE name = ('#{account_holder}')")
        return bal
    end
    
    def deposit(money)
        bal = balance()
        new_balance = bal + money
        st = @db.query("INSERT INTO accounts (balance) VALUES ('#{new_balance}')")
    end
    
    def withdraw(money)
        bal = balance()
        new_balance = bal - money
        st = @db.query("INSERT INTO accounts (balance) VALUES ('#{new_balance}')")
        
    end
    
    def transfer(money, target_account)
        bal = balance()
        new_balance = bal - money
        st = @db.prepare("INSERT INTO accounts (balance) VALUES ('#{new_balance}')")
        st.execute(new_balance)
        target_account.deposit(money)
    end
    
    
end

a = Account.new('Steve')
puts a.display
a.deposit(100)
puts a.balance

b = Account.new('Jeron')
puts b.display
b.deposit(50)
puts b.balance

c = Account.find('Steve')
puts c.balance

c.transfer(25, b)
puts c.balance

d = Account.find('Jeron')
puts d.balance

