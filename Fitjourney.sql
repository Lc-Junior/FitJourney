SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS fitjourney
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE fitjourney;

CREATE TABLE usuarios (
  id_usuario BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  senha_hash VARCHAR(255) NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  ativo TINYINT(1) DEFAULT 1 COMMENT '0 = inativo, 1 = ativo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Cadastro de usuários do sistema.';

CREATE TABLE perfis (
  id_usuario BIGINT UNSIGNED PRIMARY KEY,
  idade INT NULL,
  sexo ENUM('masculino', 'feminino', 'outro') NULL,
  altura_cm DECIMAL(5,2) NULL,
  peso_atual_kg DECIMAL(6,2) NULL,
  nivel_atividade ENUM('sedentário', 'leve', 'moderado', 'intenso', 'muito_intenso') DEFAULT 'moderado',
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Informações físicas do usuário.';

CREATE TABLE medidas (
  id_medida BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_usuario BIGINT UNSIGNED NOT NULL,
  data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
  peso_kg DECIMAL(6,2) NULL,
  cintura_cm DECIMAL(5,2) NULL,
  quadril_cm DECIMAL(5,2) NULL,
  peito_cm DECIMAL(5,2) NULL,
  observacoes TEXT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Histórico de medidas e peso do usuário.';

CREATE TABLE objetivos (
  id_objetivo BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_usuario BIGINT UNSIGNED NOT NULL,
  tipo ENUM('emagrecimento', 'manutenção', 'ganho_massa') NOT NULL,
  peso_meta_kg DECIMAL(6,2) NULL,
  data_inicio DATE NOT NULL,
  data_fim DATE NULL,
  descricao TEXT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Metas e objetivos do usuário.';

CREATE TABLE alimentos (
  id_alimento BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  porcao_g DECIMAL(6,2) DEFAULT 100,
  calorias DECIMAL(6,2) DEFAULT 0,
  proteinas_g DECIMAL(6,2) DEFAULT 0,
  carboidratos_g DECIMAL(6,2) DEFAULT 0,
  gorduras_g DECIMAL(6,2) DEFAULT 0,
  criado_por BIGINT UNSIGNED NULL,
  FOREIGN KEY (criado_por) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Tabela de alimentos com valores nutricionais.';

CREATE TABLE refeicoes (
  id_refeicao BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_usuario BIGINT UNSIGNED NOT NULL,
  data_refeicao DATETIME NOT NULL,
  tipo ENUM('café_da_manhã', 'almoço', 'jantar', 'lanche') NOT NULL,
  observacoes TEXT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Registro de refeições realizadas pelo usuário.';

CREATE TABLE itens_refeicao (
  id_item BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_refeicao BIGINT UNSIGNED NOT NULL,
  id_alimento BIGINT UNSIGNED NOT NULL,
  quantidade DECIMAL(6,2) NOT NULL DEFAULT 1 COMMENT 'Quantidade consumida (porções)',
  FOREIGN KEY (id_refeicao) REFERENCES refeicoes(id_refeicao) ON DELETE CASCADE,
  FOREIGN KEY (id_alimento) REFERENCES alimentos(id_alimento) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Associação entre alimentos e refeições.';

CREATE TABLE dados_dispositivo (
  id_dado BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_usuario BIGINT UNSIGNED NOT NULL,
  data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
  passos INT DEFAULT 0,
  calorias_gastas DECIMAL(8,2) DEFAULT 0,
  minutos_exercicio INT DEFAULT 0,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Dados importados de dispositivos externos (smartwatch, app, etc).';

CREATE TABLE conquistas (
  id_conquista BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  descricao TEXT NULL,
  pontos INT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Tabela de conquistas e recompensas.';

CREATE TABLE usuarios_conquistas (
  id_usuario BIGINT UNSIGNED NOT NULL,
  id_conquista BIGINT UNSIGNED NOT NULL,
  data_conquista DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_usuario, id_conquista),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
  FOREIGN KEY (id_conquista) REFERENCES conquistas(id_conquista) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Histórico de conquistas alcançadas por usuário.';

CREATE TABLE notificacoes (
  id_notificacao BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_usuario BIGINT UNSIGNED NOT NULL,
  titulo VARCHAR(200) NOT NULL,
  mensagem TEXT NOT NULL,
  tipo ENUM('lembrete_refeicao', 'meta', 'motivacional') DEFAULT 'motivacional',
  data_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
  lida TINYINT(1) DEFAULT 0,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Mensagens e notificações enviadas ao usuário.';

SET FOREIGN_KEY_CHECKS = 1;