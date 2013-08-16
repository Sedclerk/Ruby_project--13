require "mysql"

class Account
    
    attr_accessor :account_holder, :balance

    def initialize(account_holder)
        @account_holder = account_holder
        @balance = 0
        
        @db = Mysql.new 'localhost', 'root', 'Sedclerk13', 'tsiky'
        st = @db.query("INSERT INTO accounts(name, balance) VALUES ( '#{account_holder}' , 0)")
    end

    def balance
        bal = balance()
        st = @db.query("SELECT balance FROM accounts WHERE name = ('#{account_holder}')")
        st.execute(bal)
        st.close if st
    end

    def deposit(money)
        bal = balance()
        new_balance = money + bal
        st = @db.prepare("INSERT INTO accounts balance VALUES ('#{new_balance}')")
        st.execute (new_balance)
        st.close if st
    end

    def withdraw(money)
        bal = balance()
        new_balance = money - bal
        st = @db.prepare("INSERT INTO accounts (balance) VALUES ('#{new_balance}')")
        st.execute (new_balance)
        st.close if st
    end

    def transfer(money, target_account)
        bal = balance()
        new_balance = money - bal
        target_account.deposit(money)
        st = @db.prepare("INSERT INTO accounts (balance) VALUES ('#{new_balance}')")
        st.execute (new_balance)
        st.close if st
    end
    
    def display
        
        puts "Your Name's account: "+ @account_holder
        puts "Your Balance: " + @balance.to_s
    end
    
end

a = Account.new('Steve')
a.deposit(100)
puts a.balance

b = Account.new('Jeron') 
b.deposit(50)
puts b.balance

c = Account.find('Steve')  
puts c.balance

c.transfer(25, b)
puts c.balance

d = Account.find('Jeron')
puts d.balance

