require "mysql"

class Account
    
    attr_accessor :account_holder, :balance
    
    def initialize(account_holder)
        @account_holder = account_holder
        
        @db = Mysql.new 'localhost', 'root', 'Sedclerk13', 'Tsiky'
        st = @db.query("INSERT INTO accounts(name, balance) VALUES ( '#{account_holder}' , 0)")
    end
    
    def balance
        st = @db.query("SELECT balance FROM accounts WHERE name = '#{account_holder}' LIMIT 1")
        result = st.fetch_hash
        return result['balance']
    end
    
    def find(name)
        st = @db.query("SELECT * FROM accounts WHERE name = '#{account_holder}' LIMIT 1")
        st.each {|x| print x, " "}
    end
    
    def deposit(money)
        bal = balance()
        num = bal.to_f
        num += money
        st = @db.query("UPDATE accounts SET balance = '#{num}'  WHERE name = '#{account_holder}'")
        puts bal
    end
    
    def withdraw(money)
        bal = balance()
        num = bal.to_f
        num -= money
        st = @db.query("UPDATE accounts SET balance = '#{num}'  WHERE name = '#{account_holder}'")
        puts bal
    end
    def transfer(money, target_account)
        bal = balance()
        num = bal.to_f
        num -= money
        st = @db.query("UPDATE accounts SET balance = '#{num}'  WHERE name = '#{account_holder}'")
        target_account.deposit(money)
    end
end

a = Account.new('Steve')
a.deposit(100)
puts a.balance

b = Account.new('Jeron')
b.deposit(4000)
puts b.balance

puts a.find('Steve')

puts b.find('Jeron')

a.withdraw(10)

a.transfer(50, b)
puts a.balance

