-- Exercício 1.
DELIMITER $$
CREATE PROCEDURE ExibirAlunosPorTurma (
    IN p_codigo_turma VARCHAR(15)
)
BEGIN
    SELECT a.nro_matricula, a.nome_aluno
    FROM aluno a
    WHERE a.codigo_turma = p_codigo_turma;
END $$
DELIMITER ;

-- Exemplo de chamada para a turma com código 'TURMA123'
CALL ExibirAlunosPorTurma('TURMA003');


-- Exercício 2.
DELIMITER $$
CREATE PROCEDURE AtualizarStatusAluno (
    IN p_nro_matricula INT,
    IN p_novo_status VARCHAR(20)
)
BEGIN
    -- Supondo que o campo 'status' foi adicionado à tabela 'aluno'
    UPDATE aluno
    SET status = p_novo_status
    WHERE nro_matricula = p_nro_matricula;
END $$
DELIMITER ;

-- Adicionando a coluna 'status' na tabela 'aluno'
ALTER TABLE aluno ADD COLUMN status VARCHAR(20);

-- Exemplo de chamada para atualizar o status do aluno com matrícula 101 para 'Ativo'
CALL AtualizarStatusAluno(101, 'Ativo');


-- Exercício 3.
DELIMITER $$
CREATE PROCEDURE ExibirProfessoresPorDisciplina (
    IN p_codigo_disciplina VARCHAR(15)
)
BEGIN
    SELECT p.nro_registro_professor, p.nome
    FROM professor p
    WHERE p.codigo_disciplina = p_codigo_disciplina;
END $$
DELIMITER ;

-- Exemplo de chamada para a disciplina com código 'DISC123'
CALL ExibirProfessoresPorDisciplina('DISC001');

-- Exercício 4.
DELIMITER $$
CREATE PROCEDURE InserirNovaTurma (
    IN p_nro_alunos INT,
    IN p_periodo VARCHAR(20),
    IN p_semestre INT,
    IN p_status VARCHAR(20)
)
BEGIN
    -- Gerando um código único para a nova turma
    SET @novo_codigo_turma = CONCAT('TUR-', UUID());
   
    INSERT INTO turma (codigo_turma, nro_alunos, sigla_curso, nro_registro_professor, periodo)
    VALUES (@novo_codigo_turma, p_nro_alunos, NULL, NULL, p_periodo);

    -- Exibindo a confirmação de inserção
    SELECT @novo_codigo_turma AS codigo_turma, p_nro_alunos, p_periodo, p_semestre, p_status AS status;
END $$
DELIMITER ;

-- Exemplo de chamada para inserir uma nova turma com 30 alunos, no período 'Noturno', no semestre 2, com status 'Ativa'
CALL InserirNovaTurma('TURMA004', 30, 'CURSO004', 'PROF004', 'Noturno');



-- Exercício 5.
DELIMITER $$
CREATE PROCEDURE AtualizarEspecialidadeProfessor (
    IN p_nro_registro_professor VARCHAR(15),
    IN p_nova_especialidade VARCHAR(50)
)
BEGIN
    -- Supondo que o campo 'especialidade' foi adicionado à tabela 'professor'
    UPDATE professor
    SET especialidade = p_nova_especialidade
    WHERE nro_registro_professor = p_nro_registro_professor;
END $$
DELIMITER ;

-- Adicionando a coluna 'especialidade' na tabela 'professor'
ALTER TABLE professor ADD COLUMN especialidade VARCHAR(50);

-- Exemplo de chamada para atualizar a especialidade do professor com registro 'PROF456' para 'Matemática Avançada'
CALL AtualizarEspecialidadeProfessor('PROF002', 'Matemática Avançada');



select * from professor