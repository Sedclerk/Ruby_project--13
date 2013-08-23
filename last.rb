require "mysql"

class Account
    
    attr_accessor :account_holder, :balance
    
    def initialize(account_holder)
        @account_holder = account_holder
        
        @db = Mysql.new 'localhost', 'root', 'Sedclerk13', 'Tsiky'
        st = @db.query("INSERT INTO accounts(name, balance) VALUES ( '#{account_holder}' , 0)")
    end
    
    def balance # This is the balance i talked about
        st = @db.query("SELECT balance FROM accounts WHERE name = '#{account_holder}' LIMIT 1")
        result = st.fetch_hash
        return result['balance']
    end
    
    def find(name)
      st = @db.query("SELECT * FROM accounts WHERE name = '#{account_holder}'")
      st.each {|x| print x, " "}
    end
    def deposit(money)
        bal = balance()
        bal = @db.query("UPDATE accounts SET balance = '#{bal}'  WHERE name = '#{account_holder}'")
        puts "Deposited #{money}. New balance: $#{@bal}."
    end
    end

a = Account.new('OUI5')

a.deposit(33333)
puts a.balance

b = Account.new('YES5')
b.deposit(5555)
puts b.balance

puts a.find('OUI5')
puts b.find('YES5')

a.transfer(25, b)
puts a.balance

