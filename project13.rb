require "mysql"

class Account
    
    attr_accessor :account_holder
    
    def initialize(account_holder)
        @account_holder = account_holder
        @db = Mysql.connect'localhost', 'root', 'Sedclerk13','bankbe'
        st = @db.query("INSERT INTO accounts(name, balance) VALUES ( account_holder , 0)")
    end
    
    def balance
        st = @db.query("SELECT balance FROM accounts WHERE name = ?")
        results.each_hash do |row|
            puts "The holder name is #{row.name}: the balance is #{row.balance}"
        end
    end
    
    def deposit(money)
        vola = money[:balance]
        money[:balance]= money[:balance] + money
        st = @db.prepare('INSERT into accounts (balance) VALUES (?)')
        st.execute(vola)
    end
    
    def withdraw(money)
        vola = money[:balance]
        money[:balance]= money[:balance] - money
        st = @db.prepare('INSERT into accounts (balance) VALUES (?)')
        st.execute(vola)
    end
    
    def transfer(amount, target_account)
        vola = money[:balance]
        money[:balance]= money[:balance] - money
        target_account.deposit(amount)
        st = @db.prepare('INSERT into accounts (balance) VALUES (?)')
        st.execute(vola)
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

