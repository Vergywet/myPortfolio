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
    // formulate the sql to insert a new record into the employee table
    // staffnum,surname,firstnames,said,dept,position,emptype,email,empdate,createdate,notes

    $sql = "INSERT INTO employee (staffnum,surname,firstnames,said,dept,position,emptype,email,empdate,createdate,notes) 
    VALUES ('2402','Radebe','Obed','7407215402083','MKT','Hod','academic','radebe.obed@pradtech.co.za', '2020-01-01', '2024-06-25', 'This is a test')";
   
    // execute the query
    $result = $conn->query($sql); // symbol ind the dot notation
    // check if we have any results and if so, display each row's field name and data
    if ($result === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // close the connection
    $conn->close();

    ?>
</body>
</html>