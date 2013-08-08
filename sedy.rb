
require 'mysql'

begin
    con = Mysql.new 'localhost', 'root', 'Sedclerk13', 'malagasy'
    con.query("CREATE TABLE accounts ( Id INT PRIMARY KEY AUTO_INCREMENT, name varchar(50), balance integer)")
    con.query("INSERT INTO accounts (name, balance) VALUES('Jeron', 4000)")
    con.query("INSERT INTO accounts (name, balance) VALUES('Steve', 3000)")
    con.query("UPDATE accounts SET balance = 3500 WHERE name = 'Jeron'")
    con.query("DELETE from accounts WHERE balance = 3000")
    con.query("SELECT * FROM accounts")
    rescue Mysql::Error => e
    puts e.errno
    puts e.error
    ensure
    con.close if con
end

