<!DOCTYPE html>
<html>
    <head>
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <title></title>
    </head>
    <body>
        
            <h1>Formulario de atualização de Usuários</h1>
        <div class="col-md-4 mb-3">
            <hr>
        </div>
		<div class="col-md-4 mb-3">
        <?php
            require '../Modelo/ClassUsuario.php';
            require '../Modelo/DAO/ClassUsuarioDAO.php';
			$id =@$_GET['idex'];
            $novoUsuario = new ClassUsuario();
            $usuarioDAO = new ClassUsuarioDAO();
            $novoUsuario = $usuarioDAO->buscarUsuario($id);

        ?>
        <form method="post" action="../Controle/ControleUsuario.php?ACAO=alterarUsuario" >
                <input type="hidden" name="idex" value="<?php echo $novoUsuario->getIdUsuario(); ?>">
                Nome:<input class="form-control" type="text" name="nome" size="50" value="<?php echo $novoUsuario->getNome(); ?>" /><br>
                <br>
				<button class="btn btn-primary" type="submit" value="Alterar">Alterar</button> 
				<button class="btn btn-primary" type="reset" value="Limpar">Limpar</button>
            </div>
        </form>
    </body>
</html>
