<?php 
require 'db.php'; 

$data = json_decode(file_get_contents("php://input")); 

$correo = $data->correo; 
$password = password_hash($data->password, PASSWORD_BCRYPT); 

$sql = "INSERT INTO users (correo, password) VALUES ('$correo', '$password')"; 

if ($conn->query($sql) === TRUE) { 
    echo json_encode(["status" => "success", "message" => "Usuario registrado con éxito"]); 
} else { 
    echo json_encode(["status" => "error", "message" => "Error al registrar usuario: " . $conn->error]); 
} 
?>
