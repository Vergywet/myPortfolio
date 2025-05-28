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
    // Create vars and set values as per row 3 of the provided data
    //2403,Zuma,Jacob,8607201234081,ICT,Lecturer,academic,Jzuma,01-Jan-12,24-Jun-24,blabla3

    $staffnum= "2403" ;
    $surname = "Zuma";
    $firstnames ="Jacob";
    $said ="8607201234081";
    $dept="ICT";
    $position= "Lecturer";
    $emptype = "academic";
    $email= "Jzuma@pradtech.co.za";
    $empdate="01-Jan-2012";
    $createdate= date("d-m-Y");
    $notes="BlaBlaBla3";
    
    //formulate the sql to insert a new record into the employee table
    // staffnum,surname,firstnames,said,dept,position,emptype,email,empdate,createdate,notes
    // note the single quotes around the variable names - EXPLAIN

    $sql = "INSERT INTO employee (staffnum,surname,firstnames,said,dept,position,emptype,email,empdate,createdate,notes) 
    VALUES ('$staffnum','$surname','$firstnames','$said','$dept','$position','$emptype','$email', '$empdate', '$createdate', '$notes')";
   
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