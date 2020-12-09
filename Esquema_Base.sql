--###########################################################
-- GRUPO 02
-- Antônio Sebastian Fernandes Rabelo - Nº USP 10797781
-- João Marcos Della Torre Divino - Nº USP 10377708
-- Jonathan Ferreira de Mello - Nº USP 10377754
-- Paulo Inay Cruz - Nº USP 10388691
--###########################################################
-- BANCO DE DADOS SCRIPT ESQUEMA - PARTE 03
select 'drop table '||table_name||' cascade constraints;' from user_tables;

commit;

create table PESSOA(
    CPF number not null,
    Pessoa_Nome varchar2(150) not null,
    DataNascimento date not null,
    Idade number,
    Peso number,
    Altura number,
    Pessoa_Rua varchar2(150),
    Pessoa_Numero number,
    Pessoa_Bairro varchar2(100),
    Pessoa_CEP number not null,
    Pessoa_Cidade varchar2(100) not null,
    Pessoa_UF varchar2(3) not null,

    CONSTRAINT PK_PESSOA PRIMARY KEY (CPF)
);

create table DOADOR (
    Doador_Pessoa number not null,
    DataCadastro date not null,
    TempoContribuicao number,   --anos

    CONSTRAINT PK_DOADOR PRIMARY KEY (Doador_Pessoa),
    CONSTRAINT FK_DOADOR FOREIGN KEY (Doador_Pessoa) 
        REFERENCES PESSOA(CPF)
        ON DELETE CASCADE
);

create table ENFERMO(
    Enfermo_Pessoa number not null,
    Gravidade varchar2(30) not null,
    TipoSanguineo_Enfermo varchar2(3) not null,

    CONSTRAINT PK_ENFERMO PRIMARY KEY (Enfermo_Pessoa),
    CONSTRAINT FK_ENFERMO FOREIGN KEY (Enfermo_Pessoa)
        REFERENCES PESSOA(CPF)
        ON DELETE CASCADE
);

create table PROFISSIONAL_SAUDE (
    Profissional_Saude_Pessoa number not null,
    AreaAtuacao varchar2(50) not null,
    NroRegistro number not null,

    CONSTRAINT PK_PROFISSIONAL_SAUDE PRIMARY KEY (Profissional_Saude_Pessoa),
    CONSTRAINT FK_PROFISSIONAL_SAUDE FOREIGN KEY (Profissional_Saude_Pessoa)
        REFERENCES PESSOA(CPF)
        ON DELETE CASCADE,
    CONSTRAINT SK_PROFISSIONAL_SAUDE UNIQUE (NroRegistro)
);

    
    --- TESTADO AT� AQUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
    
    
    
    
create table HOSPITAL(
    Hospital_CNPJ number not null,
    Hospital_Nome varchar2 (150) not null,
    Hospital_Rua varchar2(150) not null,
    Hospital_Numero number not null,
    Hospital_Bairro varchar2(150) not null,
    Hospital_CEP number not null, 
    Hospital_Cidade varchar2(50) not null,
    Hospital_UF char(2) not null,

    CONSTRAINT PK_HOSPITAL PRIMARY KEY (Hospital_CNPJ)
);

create table INSTITUICAO(
    Instituicao_CNPJ number not null,
    Instituicao_Nome varchar2 (150) not null,
    Instituicao_Rua varchar2(150) not null,
    Instituicao_Numero number not null,
    Instituicao_Bairro varchar2(150) not null,
    Instituicao_CEP number not null,
    Instituicao_Cidade varchar2(50) not null,
    Instituicao_UF char(2) not null,

    CONSTRAINT PK_INSTITUICAO PRIMARY KEY (Instituicao_CNPJ)
);

create table LABORATORIO(
    Laboratorio_CNPJ number not null,
    Laboratorio_Nome varchar2 (150) not null,
    Laboratorio_Rua varchar2(150) not null,
    Laboratorio_Numero number not null,
    Laboratorio_Bairro varchar2(150) not null,
    Laboratorio_CEP number not null,
    Laboratorio_Cidade varchar2(50) not null,
    Laboratorio_UF char(2) not null,

    CONSTRAINT PK_LABORATORIO PRIMARY KEY (Laboratorio_CNPJ)
);

create table MEDICAMENTOS(
    Medicamento_Nome varchar2(100) not null,
    EmpresaProdutora varchar2(100) not null,
    Medicamento_Tipo varchar2(30) not null,
    Tarja varchar2(10) not null,
    NroLote number not null,
    PrazoValidade number not null,
    NroRegistro number not null,
    PrincipioAtivo varchar2(150) not null,

    CONSTRAINT PK_MEDICAMENTOS PRIMARY KEY (Medicamento_Nome, EmpresaProdutora)
);

create table DOACAO_MEDICAMENTOS(
    Doacao_Medicamentos_Id number not null,
    Doacao_Medicamentos_Nome varchar2(100) not null,
    Doacao_Medicamentos_Empresa_Produtora varchar2(100) not null,
    Doacao_Medicamentos_Data date not null,
    Doacao_Medicamentos_Doador number not null,
    Doacao_Medicamentos_Qtde number not null,

    CONSTRAINT PK_DOACAO_MEDICAMENTOS PRIMARY KEY (Doacao_Medicamentos_Id),
    CONSTRAINT FK1_DOACAO_MEDICAMENTOS FOREIGN KEY (Doacao_Medicamentos_Nome, 
                                                    Doacao_Medicamentos_Empresa_Produtora)
        REFERENCES MEDICAMENTOS(Medicamento_Nome, EmpresaProdutora),
    CONSTRAINT FK2_DOACAO_MEDICAMENTOS FOREIGN KEY (Doacao_Medicamentos_Doador)
        REFERENCES MEDICAMENTOS(Doador_Pessoa),
    CONSTRAINT SK_DOACAO_MEDICAMENTOS UNIQUE (Doacao_Medicamentos_Nome, Doacao_Medicamentos_Empresa_Produtora,
                                                Doacao_Medicamentos_Data, Doacao_Medicamentos_Doador)

);

create table RECEPCAO_MEDICAMENTOS(
    Doacao_Medicamento number not null,
    Recepcao_Medicamento_Enfermo varchar2(150) not null,
    Recepcao_Medicamento_Data date not null,
    Recepcao_Medicamento_Qtde number not null,

    CONSTRAINT PK_RECEPCAO_MEDICAMENTOS PRIMARY KEY (Doacao_Medicamento,Recepcao_Medicamento_Enfermo,
                                                    Recepcao_Medicamento_Data),
    CONSTRAINT FK1_RECEPCAO_MEDICAMENTOS FOREIGN KEY (Doacao_Medicamento)
        REFERENCES DOACAO_MEDICAMENTOS(Doacao_Medicamentos_Id),
    CONSTRAINT FK2_RECEPCAO_MEDICAMENTOS FOREIGN KEY (Recepcao_Medicamento_Enfermo)
        REFERENCES ENFERMO(Enfermo_Pessoa)
);

create table EQUIPAMENTO(
    Equipamento_Modelo varchar2(150) not null,
    Equipamento_Fabricante varchar2 (150) not null,
    Dados_Tecnicos varchar2 (150),
    Classe_De_Risco varchar2 (150) not null,
    Equipamento_Tipo varchar2 (150) not null,
    Equipamento_Registro_Anvisa number not null,
    Equipamento_Qtde_Disponivel number,

    CONSTRAINT PK_EQUIPAMENTO PRIMARY KEY (Equipamento_Modelo, Equipamento_Fabricante),
);

create table DOACAO_EQUIPAMENTO(
    Doacao_Equipamento_Id number not null,
    Doacao_Equipamento_Modelo varchar2(150) not null,
    Doacao_Equipamento_Fabricante varchar2(150) not null,
    Doacao_Equipamento_Data date not null,
    Doacao_Equipamento_Instituicao varchar2(150) not null,
    Doacao_Equipamento_Qtde number not null,

    CONSTRAINT PK_DOACAO_EQUIPAMENTO PRIMARY KEY (Doacao_Equipamento_Id),
    CONSTRAINT FK1_DOACAO_EQUIPAMENTO FOREIGN KEY (Doacao_Equipamento_Modelo, Doacao_Equipamento_Fabricante)
        REFERENCES EQUIPAMENTO(Equipamento_Modelo, Equipamento_Fabricante),
    CONSTRAINT FK2_DOACAO_EQUIPAMENTO FOREIGN KEY (Doacao_Equipamento_Instituicao)
        REFERENCES INSTITUICAO(Instituicao_CNPJ),
    CONSTRAINT SK_DOACAO_EQUIPAMENTO UNIQUE (Doacao_Equipamento_Modelo, Doacao_Equipamento_Fabricante,
                                            Doacao_Equipamento_Data, Doacao_Equipamento_Instituicao)
);

create table RECEPCAO_EQUIPAMENTO(
    Doacao_Equipamento number not null,
    Recepcao_Equipamento_Hospital number not null,
    Recepcao_Equipamento_Data date not null,
    Recepcao_Equipamento_Qtde number not null,

    CONSTRAINT PK_RECEPCAO_EQUIPAMENTO PRIMARY KEY (Doacao_Equipamento, Recepcao_Equipamento_Hospital,
                                                    Recepcao_Equipamento_Data)
    CONSTRAINT FK1_RECEPCAO_EQUIPAMENTO FOREIGN KEY (Doacao_Equipamento)
        REFERENCES DOACAO_EQUIPAMENTO(Doacao_Equipamento_Id),
    CONSTRAINT FK2_RECEPCAO_EQUIPAMENTO FOREIGN KEY (Recepcao_Equipamento_Hospital)
        REFERENCES HOSPITAL(Hospital_CNPJ)
        
);

create table CONSULTA(
    Consulta_Id number not null,
    Consulta_Enfermo number not null,
    Consulta_Data date not null,
    Consulta_Profissional_Saude number not null,
    
    CONSTRAINT PK_CONSULTA PRIMARY KEY (Consulta_Id),
    CONSTRAINT FK1_CONSULTA FOREIGN KEY (Consulta_Enfermo)
        REFERENCES ENFERMO(Enfermo_Pessoa),
    CONSTRAINT FK2_CONSULTA FOREIGN KEY (Consulta_Profissional_Saude)
        REFERENCES PROFISSIONAL_SAUDE (Profissional_Saude_Pessoa),
    CONSTRAINT SK_CONSULTA UNIQUE (Consulta_Enfermo, Consulta_Data, Consulta_Profissional_Saude)
);

create table EXAME(
    Exame_Laboratorio number not null,
    Exame_Consulta number not null,
    Exame_Data date not null,
    Exame_Tipo varchar2(100) not null,
    Tecnico varchar2(150) not null,
    
    CONSTRAINT PK_EXAME PRIMARY KEY (Exame_Laboratorio, Exame_Consulta, Exame_Data, Exame_Tipo),
    CONSTRAINT FK1_EXAME FOREIGN KEY (Exame_Laboratorio)
        REFERENCES LABORATORIO(Laboratorio_CNPJ),
    CONSTRAINT FK2_EXAME FOREIGN KEY (Exame_Consulta)
        REFERENCES CONSULTA(Consulta_Id)
);

create table ENFERMEIRO(
    Enfermeiro_Profissional_Saude number not null,

    CONSTRAINT PK_ENFERMEIRO PRIMARY KEY (Enfermeiro_Profissional_Saude)
    CONSTRAINT FK_ENFERMEIRO FOREIGN KEY (Profissional_Saude_Pessoa)
);

create table CIRURGIAO(
    Cirurgiao_Profissional_Saude number not null,

    CONSTRAINT PK_CIRURGIAO PRIMARY KEY (Cirurgiao_Profissional_Saude)
    CONSTRAINT FK_CIRURGIAO FOREIGN KEY (Profissional_Saude_Pessoa)
);

create table TRANSPLANTE(
    Transplante_Id number, 
    Transplante_Enfermo number not null,
    Transplante_Cirurgiao number not null,
    Transplante_Data date not null,
    Transplante_Hospital number not null,
    
    CONSTRAINT PK_TRANSPLANTE PRIMARY KEY (Transplante_Id),
    CONSTRAINT FK1_TRANSPLANTE FOREIGN KEY (Transplante_Enfermo)
        REFERENCES Enfermo (Enfermo_Pessoa),
    CONSTRAINT FK2_TRANSPLANTE FOREIGN KEY (Transplante_Cirurgiao)
        REFERENCES Enfermeiro (Cirurgiao_Profissional_Saude),
    CONSTRAINT SK_TRANSPLANTE UNIQUE (Transplante_Enfermo, Transplante_Enfermeiro, Transplante_Data)
);

create table TRANSFUSAO(
    -- Id, Enfermo*, Enfermeiro*, Data*, Hospital*
    Transfusao_Id number,
    Transfusao_Enfermo number not null,
    Transfusao_Enfermeiro number not null,
    Transfusao_Data date not null,
    Transfusao_Hospital number not null,
    
    CONSTRAINT PK_TRANSFUSAO PRIMARY KEY (Transfusao_Id),
    CONSTRAINT FK1_TRANSFUSAO FOREIGN KEY (Transfusao_Enfermo)
        REFERENCES Enfermo (Enfermo_Pessoa),
    CONSTRAINT FK2_TRANSFUSAO FOREIGN KEY (Transfusao_Enfermeiro)
        REFERENCES Enfermeiro (Enfermeiro_Profissional_Saude),
    CONSTRAINT SK_TRANSFUSAO UNIQUE (Transfusao_Enfermo, Transfusao_Enfermeiro, Transfusao_Data)
);

create table SANGUE(
    Sangue_Doador number not null,
    Sangue_Data date not null,
    Sangue_TipoSanguineo varchar2(10) not null,
    Sangue_BancoArmazenamento varchar2(100) not null,
    Sangue_Qtde number not null,
    Sangue_DataValidade date not null,
    Sangue_Transfusao number,

    CONSTRAINT PK_SANGUE PRIMARY KEY (Sangue_Doador, Sangue_Data),
    CONSTRAINT FK1_SANGUE FOREIGN KEY (Sangue_Doador)
        REFERENCES DOADOR(Doador_Pessoa),
    CONSTRAINT FK2_SANGUE FOREIGN KEY (Sangue_Transfusao)
        REFERENCES TRANSFUSAO(Transfusao_Id)
);

create table ORGAOS(
    Orgao_Nome varchar2(100),
    Orgao_Doador number,
    Orgao_Data date,
    Orgao_Data_Validade date not null,
    Orgao_Banco_Armazenamento_ varchar2(100) not null,
    Orgao_Teste_Compatibilidade number, -- PERGUNTAR COMO FUNCIONA O BFILE
    Orgao_Transplante number,
    
    CONSTRAINT PK_ORGAOS PRIMARY KEY (Nome_Orgao, Orgao_Doador, Orgao_Data),
    CONSTRAINT FK1_ORGAOS FOREIGN KEY (Orgao_Doador)
        REFERENCES DOADOR(Doador_Pessoa),
    CONSTRAINT FK2_ORGAOS FOREIGN KEY (Orgao_Transplante)
        REFERENCES TRANSPLANTE(Transplante_Id)
);

create table TIPO(
    --Dar um CHECK em relação ao Tipo_Pessoa
    Tipo_Pessoa number,
    Tipo_Tipo_Pessoa varchar2(30),

    CONSTRAINT PK_TIPO PRIMARY KEY (Tipo_Pessoa, Tipo_Tipo_Pessoa)
);

create table ENFERMO_ALERGIAS(
    Enfermo_Alergia number,
    Alergia varchar2 (500), --Conjunto de Alergias
    
    CONSTRAINT PK_ENFERMO_ALERGIAS PRIMARY KEY (Enfermo_Alergia, Alergia),
    CONSTRAINT FK_ALERGIA FOREIGN KEY (Enfermo_Alergia)
        REFERENCES ENFERMO (Enfermo_Pessoa)
);

create table ENFERMO_DOENCAS(
    Enfermo_Doencas varchar2(150),
    Doenca varchar2(500),

    CONSTRAINT PK_ENFERMO_DOENCAS PRIMARY KEY (Enfermo_Doencas, Doenca),
    CONSTRAINT FK_DOENCA FOREIGN KEY (Enfermo_Doencas)
        REFERENCES ENFERMO (Enfermo_Pessoa)
);

create table RECEITAS_MEDICAS(
    Receitas_Enfermo varchar2(150),
    Receita varchar2(150),

    CONSTRAINT PK_RECEITAS_ENFERMO PRIMARY KEY (Enfermo_Doencas, Doenca),
    CONSTRAINT FK_RECEITA FOREIGN KEY (Enfermo_Doencas)
        REFERENCES ENFERMO (Enfermo_Pessoa)
);

create table SERVICOS_OFERECIDOS(
    Laboratorio_Prestador number,
    Servicos varchar(500),
    
    CONSTRAINT PK_SERVICOS_OFERECIDOS (Laboratorio_Prestador,Servicos),
    CONSTRAINT FK_SERVICOS_OFERECIDOS FOREIGN KEY (Laboratorio_Prestador)
        REFERENCES LABORATORIO (Laboratorio_CNPJ)

);