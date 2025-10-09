<?php
require_once 'Conexao.php';
class ClassUsuarioDAO
{

    public function listarUsuarios()
    {
        try {
            $pdo = Conexao::getInstance();
            $sql = "SELECT * FROM usuarios";
            $stmt = $pdo->prepare($sql);
            $stmt->execute();
            $itens = $stmt->fetchAll(PDO::FETCH_ASSOC);
            return $itens;
        } catch (PDOException $exc) {
            echo $exc->getMessage();
        }
    }


    public function alterarUsuario(ClassUsuario $alterarUsuario)
    {
        try {
            $pdo = Conexao::getInstance();
            $sql = "UPDATE Usuario SET nome=? WHERE idUsuario=? ";
            $stmt = $pdo->prepare($sql);
            $stmt->bindValue(1, $alterarUsuario->getNome());
            $stmt->bindValue(3, $alterarUsuario->getIdUsuario());
            $stmt->execute();
            return $stmt->rowCount();
        } catch (PDOException $ex) {
            echo $ex->getMessage();
        }
    }

    public function excluirUsuarios($idUsuario)
    {
        try {
            $pdo = Conexao::getInstance();
            $sql = "DELETE FROM Usuario WHERE idUsuario =:idUsuario";
            $stmt = $pdo->prepare($sql);
            $stmt->bindValue(':idUsuario', $idUsuario);
            $stmt->execute();
            return TRUE;
        } catch (PDOException $exc) {
            // echo $ex->getMessage();
        }
    }
}