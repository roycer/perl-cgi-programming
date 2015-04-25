#!/usr/bin/perl -wTi
use CGI qw(:standard);
use DBI;

$cod = param('codigo');

print "Content-type:text/html \n\n";
$hostname = 'localhost';
$port=3306;
$username='rcondori';
$password='kzw8x6qr';
$database='rcondori';
$dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh = DBI->connect($dsn,$username,$password) or die ("no se puede conectar");
if(length($cod)==0 ){
$sth = $dbh->prepare("DELETE FROM foco");
$sth->execute();
}
else {
$sth = $dbh->prepare("DELETE FROM foco where codigo=?");
$sth->execute($cod);
}
$sth = $dbh->prepare("Select codigo,estado from foco");
$sth->execute();

while(@res = $sth->fetchrow_array()){
    print "@res<br>";
}

$dbh->disconnect();
