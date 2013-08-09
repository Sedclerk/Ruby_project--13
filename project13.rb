require 'mysql'

class Account
     attr_accessor :account_holder
    
    
     def initialize(account_holder)
        @account_holder = account_holder
        
        db = mysql.new 'localhost', 'root', 'Sedclerk13', 'lol'
        db.query("CREATE TABLE accounts ( id integer primary key, name varchar(50), balance integer)")
        St = db.prepare("INSERT INTO accounts(name, balance) VALUES (holder_name, 0)")
        St.execute(db)
     end
    
     def balance
         St =db.prepare("SELECT balance FROM accounts WHERE name = ?")
         St.execute(db)
         return St[:balance]
     end
    
    
     def deposit(money)
         vola = money[:balance]
         money[:balance]= money[:balance] + money
         St =db.prepare('INSERT into accounts (balance) VALUES (?)')
         St.execute(vola)
     end
    
     def withdraw(money)
         vola = money[:balance]
         money[:balance]= money[:balance] - money
         St =db.prepare('INSERT into accounts (balance) VALUES (?)')
         St.execute(vola)
     end
    
     def transfer(amount, target_account)
         vola = money[:balance]
         money[:balance]= money[:balance] - money
         target_account.deposit(amount)
         St =db.prepare('INSERT into accounts (balance) VALUES (?)')
         St.execute(vola)        
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

