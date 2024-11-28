<?php
require 'db.php';

$data = json_decode(file_get_contents("php://input"));

$id = $data->id;

$sql = "DELETE FROM peliculas WHERE id = $id";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status" => "success", "message" => "Película eliminada con éxito"]);
} else {
    echo json_encode(["status" => "error", "message" => "Error al eliminar película"]);
}
?>
