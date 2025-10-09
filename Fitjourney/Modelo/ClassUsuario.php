<?php
class ClassUsuario
{
    private $idUsuario;
    private $nome;
    private $email;
    private $senha_hash;
    private $data_cadastro;
    private $ativo;
    
    function setNome($nome)
    {
        $this->nome = $nome;
    }

    function getNome()
    {
        return $this->nome;
    }

    function setEmail($email)
    {
        $this-> = $email;
    }

    function getEmail()
    {
        return $this->email;
    }

    function setSenha_hash($senha_hash)
    {
        $this-> = $senha_hash;
    }

    function getSenha_hash()
    {
        return $this->senha_hash;
    }

    function setData_cadastro($data_cadastro)
    {
        $this-> = $data_cadastro;
    }

    function getData_cadastro()
    {
        return $this->data_cadastro;
    }

    function setAtivo($ativo)
    {
        $this-> = $ativo;
    }

    function getAtivo()
    {
        return $this->ativo;
    }

    
}
