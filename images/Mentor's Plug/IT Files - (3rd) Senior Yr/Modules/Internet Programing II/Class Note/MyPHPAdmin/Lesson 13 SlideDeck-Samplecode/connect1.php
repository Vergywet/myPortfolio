<!DOCTYPE html>
<html>
<head>
    <title>My PHP Page</title>
</head>
<body>
    <?php
    //setup the vars required for connecting to DB using mySqli class/object
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "pradtechcc";
    // create the connection to the DB
    $conn = new mysqli($servername, $username, $password, $dbname);
    // check the connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    echo "Connected successfully";
    echo "<br><hr><br>";
    // formulate the sql command to grab all data from the table
    $sql = "SELECT * FROM employee";
    // execute the sql command
    $result = $conn->query($sql);
    // check if there are any records returned
    if ($result->num_rows > 0) {
        // output the data of each row - note that here we are only working (outputting) a few fields!
        while($row = $result->fetch_assoc()) {
            echo "Staff Number: " . $row["staffnum"]. " - Fullname: " . $row["firstnames"]. " " . $row["surname"]. "<br>";
        }
    } else {
        echo "0 results";
    }
    // close the connection, returning all recourses to the system
    $conn->close();

    ?>
</body>
</html>