<?php
    //open connection to mysql db
    $connection = mysqli_connect("localhost","root","","smart_foundry") or die("Error " . mysqli_error($connection));

    //fetch table rows from mysql db
    $sql = "select * from smart_foundry";
    $result = mysqli_query($connection, $sql) or die("Error in Selecting " . mysqli_error($connection));

    //create an array
    $emparray = array();
    while($row =mysqli_fetch_assoc($result))
    {
        $macharray[] = $row;
    }
    //write to json file
    $fp = fopen('machdata.json', 'w');
    fwrite($fp, json_encode($macharray));
    fclose($fp);
    //close the db connection
    mysqli_close($connection);
?>