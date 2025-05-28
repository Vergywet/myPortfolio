<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Website</title>
</head>
<body>
    <?php
    // set up the vars needed to create a connection
    $server = "localhost";
    $username = "root";
    $password = "";
    $database = "pradtechcc";
    // create a connection
    $conn = new mysqli($server, $username, $password, $database);
    // check the connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    echo "Connected successfully <br><hr><br>";

    // formulate the sql to grab all records from the employee table
    $sql = "SELECT * FROM employee";  // sql commands need to be double quoted...

    // execute the query
    $result = $conn->query($sql);

    // check if we have any results and if so, display each row's field name and data
    if ($result->num_rows > 0) {
        // output the data of each row
        while($row = $result->fetch_assoc()) {
      //      echo "id: " . $row["id"]. " - staffnum: " . $row["staffNum"]. "- surname " . $row["surname"]. "<br>";
       echo "staff Number: ". $row["staffnum"]."<br>";
       echo "Surname: ". $row["surname"]."<br>";
       echo "First Name(s): ". $row["firstnames"]."<br>";
      //Other fields include: surname;firstnames;said;dept;position;emptype;email;empdate;createdate;notes
      
        }
    } else {
        echo "0 results";
    }
    // close the connection
    $conn->close();

    ?>
</body>
</html>