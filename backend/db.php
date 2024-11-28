<?php 
$host = "localhost"; 
$user = "root"; 
$pass = ""; 
$dbname = "catalogo_peliculas"; 

$conn = new mysqli($host, $user, $pass, $dbname); 

if ($conn->connect_error) { 
    die(json_encode(["status" => "error", "message" => "Error en la conexión: " . $conn->connect_error]));
}
echo "Conexión exitosa a la base de datos: " . $conn->host_info;

?>
