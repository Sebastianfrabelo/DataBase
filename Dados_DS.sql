--Dados Doando Saúde

insert into PESSOA (CPF, Pessoa_Nome, DataNascimento, Idade, Peso, Altura, Pessoa_Rua, Pessoa_Numero, Pessoa_Bairro, Pessoa_CEP, Pessoa_Cidade, Pessoa_UF)
    values (12345678901, 'Fulano de Tal', TO_DATE('2000/09/02', 'YYYY/MM/DD'), 20, 65, 1.77, 'São Cristovão',190,'Vila Maria', 16566890, 'São Carlos','SP');
insert into PESSOA (CPF, Pessoa_Nome, DataNascimento, Idade, Peso, Altura, Pessoa_Rua, Pessoa_Numero, Pessoa_Bairro, Pessoa_CEP, Pessoa_Cidade, Pessoa_UF)
    values (45678901123, 'Ciclano de Tal', TO_DATE('1998/09/02', 'YYYY/MM/DD'), 22, 95, 2.07, 'São Sebastião',190,'Vila São José', 18566891, 'Araraquara','SP');
insert into PESSOA (CPF, Pessoa_Nome, DataNascimento, Idade, Peso, Altura, Pessoa_Rua, Pessoa_Numero, Pessoa_Bairro, Pessoa_CEP, Pessoa_Cidade, Pessoa_UF)
    values (78901123456, 'Deltrana de Tal', TO_DATE('1993/09/02', 'YYYY/MM/DD'), 27, 82, 1.82, 'São Sebastião',120,'Vila São José', 18566891, 'Araraquara','SP');

insert into DOADOR (Doador_Pessoa, DataCadastro, TempoContribuicao)
    values (12345678901, TO_DATE('2019/08/02', 'YYYY/MM/DD'), 1);
insert into DOADOR (Doador_Pessoa, DataCadastro, TempoContribuicao)
    values (45678901123, TO_DATE('2018/08/02', 'YYYY/MM/DD'), 2);
    
insert into ENFERMO (Enfermo_Pessoa, Gravidade, TipoSanguineo_Enfermo)
    values (78901123456, 'CRÍTICA', 'A+');
insert into ENFERMO (Enfermo_Pessoa, Gravidade, TipoSanguineo_Enfermo)
    values (12345678901, 'MÉDIA', 'AB');
    
insert into PROFISSIONAL_SAUDE(Profissional_Saude_Pessoa, AreaAtuacao, NroRegistro)
    values (45678901123, 'Fisioterapeuta', 987654321);
    
    