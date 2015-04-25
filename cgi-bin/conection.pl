#!/usr/bin/perl -wTi
use CGI qw(:standard);
use DBI;
print "Content-type:text/html \n\n";

$nom = param('nombre');
$cod = param('codigo');
$sto = param('estado');

$hostname = 'localhost';
$port=3306;
$username='rcondori';
$password='kzw8x6qr';
$database='rcondori';
$dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh = DBI->connect($dsn,$username,$password) or die ("no se puede conectar");

$sth = $dbh->prepare("CREATE TABLE IF NOT EXISTS foco( ID int NOT NULL AUTO_INCREMENT, nombre varchar(20),codigo varchar(5) NOT NULL, estado varchar(1), PRIMARY KEY(ID))");
$sth->execute();

$sth = $dbh->prepare("SELECT COUNT(*) from foco  where codigo=?");
$sth->execute($cod);
$num = $sth->fetchrow_array();
if($num == 0){
  $sth = $dbh->prepare("INSERT INTO foco(nombre,codigo,estado) VALUES (?,?,?)");
  $sth->execute($nom,$cod,$sto);
}
else{
  $sth = $dbh->prepare("UPDATE foco set nombre=?,estado=? Where codigo=?");
  $sth->execute($nom,$sto,$cod);
}

$sth = $dbh->prepare("Select codigo,estado from foco");
$sth->execute();

while(@res = $sth->fetchrow_array()){
  print "@res<br>";
}

$dbh->disconnect();
