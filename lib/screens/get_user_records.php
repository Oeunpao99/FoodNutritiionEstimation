<?php
include('db.php'); // Include your DB connection

if (isset($_GET['user_id'])) {
    $user_id = $_GET['user_id'];

    // Query to fetch all records for the user
    $query = "SELECT * FROM user_nutrition_records WHERE user_id = ? ORDER BY created_at DESC";
    $stmt = $pdo->prepare($query);
    $stmt->execute([$user_id]);
    $records = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode(['records' => $records]);
} else {
    echo json_encode(['error' => 'User ID is required']);
}
?>
