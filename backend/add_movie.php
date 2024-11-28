<?php
require 'db.php';

$data = json_decode(file_get_contents("php://input"));

$titulo = $data->titulo;
$anio = $data->anio;
$director = $data->director;
$genero = $data->genero;
$sinopsis = $data->sinopsis;
$imagen_url = $data->imagen_url;

$sql = "INSERT INTO peliculas (titulo, anio, director, genero, sinopsis, imagen_url) 
        VALUES ('$titulo', $anio, '$director', '$genero', '$sinopsis', '$imagen_url')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status" => "success", "message" => "Película agregada con éxito"]);
} else {
    echo json_encode(["status" => "error", "message" => "Error al agregar película"]);
}
?>
