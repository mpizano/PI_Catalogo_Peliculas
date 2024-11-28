<?php 
require 'db.php'; 

$data = json_decode(file_get_contents("php://input")); 

$correo = $data->correo; 
$password = $data->password; 

$sql = "SELECT * FROM users WHERE correo = '$correo'"; 
$result = $conn->query($sql); 

if ($result->num_rows > 0) { 
    $user = $result->fetch_assoc(); 
    if (password_verify($password, $user['password'])) { 
        echo json_encode(["status" => "success", "message" => "Login exitoso"]); 
    } else { 
        echo json_encode(["status" => "error", "message" => "Contraseña incorrecta"]); 
    } 
} else { 
    echo json_encode(["status" => "error", "message" => "Usuario no encontrado"]); 
} 
?>
