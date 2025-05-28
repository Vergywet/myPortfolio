<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Employee</title>
    <link rel="stylesheet" href="myStyles.css">
</head>
<body>
    <?php
    // Initialize variables for form fields
    $staffnum=$last_name = $first_name = $sa_id = $dept = $position = $empType = $email_address = $employment_date = $notes = "";
    
    // Function to sanitize input data
    function sanitize_input($data) {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }
    
    ?>
    <div class="container">
        <h2>Add New Employee</h2>
        <?php
        // Display error or success message if set
        if (isset($error_message)) {
            echo "<p class='error'>$error_message</p>";
        } elseif (isset($success_message)) {
            echo "<p class='success'>$success_message</p>";
        }
        ?>
        <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
        <div class="form-group">
                <label for="staffnum">Staff Number:</label>
                <input type="text" id="staffnum" name="staffnum" value="<?php echo $staffnum; ?>" required>
            </div>    
        <div class="form-group">
                <label for="last_name">Last Name:</label>
                <input type="text" id="last_name" name="last_name" value="<?php echo $last_name; ?>" required>
            </div>
            <div class="form-group">
                <label for="first_name">First Name:</label>
                <input type="text" id="first_name" name="first_name" value="<?php echo $first_name; ?>" required>
            </div>
            <div class="form-group">
                <label for="sa_id">SA ID:</label>
                <input type="text" id="sa_id" name="sa_id" value="<?php echo $sa_id; ?>" required>
            </div>
            <div class="form-group">
                <label for="dept">Department:</label>
                <select id="dept" name="dept" required>
                    <option value="">Select Department</option>
                    <option value="ICT" <?php echo ($dept == 'ICT') ? 'selected' : ''; ?>>ICT</option>
                    <option value="MKT" <?php echo ($dept == 'MKT') ? 'selected' : ''; ?>>MKT</option>
                    <option value="NatCon" <?php echo ($dept == 'NatCon') ? 'selected' : ''; ?>>NatCon</option>
                    <option value="Enviro" <?php echo ($dept == 'Enviro') ? 'selected' : ''; ?>>Enviro</option>
                </select>
            </div>
            <div class="form-group">
                <label for="position">Position:</label>
                <select id="position" name="position" required>
                    <option value="">Select Position</option>
                    <option value="HOD" <?php echo ($position == 'HOD') ? 'selected' : ''; ?>>HOD</option>
                    <option value="Snr Lecturer" <?php echo ($position == 'Snr Lecturer') ? 'selected' : ''; ?>>Snr Lecturer</option>
                    <option value="Lecturer" <?php echo ($position == 'Lecturer') ? 'selected' : ''; ?>>Lecturer</option>
                    <option value="Secretary" <?php echo ($position == 'Secretary') ? 'selected' : ''; ?>>Secretary</option>
                    <option value="Technician" <?php echo ($position == 'Technician') ? 'selected' : ''; ?>>Technician</option>
                </select>
            </div>
            <div class="form-group">
                <label for="empType">Employment Type:</label>
                <select id="empType" name="empType" required>
                    <option value="">Select Employment Type</option>
                    <option value="Admin" <?php echo ($empType == 'Admin') ? 'selected' : ''; ?>>Admin</option>
                    <option value="Academic" <?php echo ($empType == 'Academic') ? 'selected' : ''; ?>>Academic</option>
                    <option value="Support" <?php echo ($empType == 'Support') ? 'selected' : ''; ?>>Support</option>
                </select>
            </div>
            <div class="form-group">
                <label for="email_address">Email Address:</label>
                <input type="email" id="email_address" name="email_address" value="<?php echo $email_address; ?>" required>
            </div>
            <div class="form-group">
                <label for="employment_date">Employment Date:</label>
                <input type="date" id="employment_date" name="employment_date" value="<?php echo $employment_date; ?>" required>
            </div>
            <div class="form-group">
                <label for="notes">Notes:</label>
                <textarea id="notes" name="notes" rows="4" required><?php echo $notes; ?></textarea>
            </div>
            <div class="form-group">
                <input type="submit" value="Submit">
            </div>
        </form>
    </div>
</body>
</html>