<?php
    $msg =@$_GET['MSG'];
    if($msg != null || $msg != ''){
        echo "<script>alert('$msg')</script>";
    }
    echo "</div>";
    ?>
    <html>
        <head>
            <title>Tela Inicial</title>
        </head>
        <body>

                <?php 
                include 'Visao/FormCadUsuario.php';
                echo "<br>;";
				include 'Visao/ListarUsuario.php';
                ?>        
    </body>
</html>
