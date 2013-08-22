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
        st.execute(name)
        st.each {|x| print x, " "}
    end
    
    def deposit(money)
        new_balance = balance()
        new_balance += money
        bal = @db.query("UPDATE accounts SET balance = '#{new_balance}'  WHERE name = '#{account_holder}'")
    end
    
    def withdraw(money)
        new_balance = balance()
        new_balance -= money
        bal = @db.query("UPDATE accounts SET balance = '#{new_balance}'  WHERE name = '#{account_holder}'")
        
    end
    
    def transfer(money, target_account)
        new_balance = balance()
        new_balance -= money
        bal = @db.query("UPDATE accounts SET balance = '#{new_balance}'  WHERE name = '#{account_holder}'")
        target_account.deposit(money)
    end
end

a = Account.new('OUI4')
a.deposit(111111)
puts a.balance

b = Account.new('YES4')
b.deposit(5555)
puts b.balance

puts a.find('OUI4')

puts b.find('NON4')

a.withdraw('12')

a.transfer(25, b)
puts a.balance

