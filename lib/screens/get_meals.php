<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

$host = "localhost";
$user = "root"; // Update with actual DB user
$password = "Dec061204P@ssword"; // Update with actual password
$database = "fnapp_db";

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

$user_id = $_POST['user_id'];

$query = "SELECT calories, fat, protein, carbs, serving_size FROM meals WHERE user_id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

$meals = [];
while ($row = $result->fetch_assoc()) {
    $meals[] = $row;
}

echo json_encode($meals);

$stmt->close();
$conn->close();
?>
