/* INSERINDO DADOS (INSERT INTO) */

/* Inserindo dados na tabela Paciente */
insert into Paciente(cpf, nome, idade, sexo)
values  ('124.039.223-04', 'Antonio Bezerra Carlos', 23, 'Masculino'),
		('125.059.225-05', 'Jessica Ferreira Silva', 20, 'Feminino'),
		('123.049.114-08', 'Fernanda Fonseca Santos', 25, 'Feminino');

/* Inserindo dados na tabela PacienteTel */
insert into PacienteTel(cpf, telefone)
values  ('124.039.223-04', '(84) 99961-0973'),
		('125.059.225-05', '(84) 99967-2112'),
		('123.049.114-08', '(84) 99990-9199');
		
/* Inserindo dados na tabela Pagamento */
insert into Pagamento(cod_pag, data_pag, valor, cpf)
values  (2, '2023-04-23', 120.00, '124.039.223-04'),
		(1, '2023-04-28', 100.00, '125.059.225-05'),
		(3, '2023-05-25', 90.00, '123.049.114-08');
		
/* Inserindo dados na tabela Medico */
insert into Medico(crm, nome)
values  ('123355/RN', 'Vitor Gabriel Azevedo'),
		('123566/PB', 'Ailton Fagner Azevedo');

/* Inserindo dados na tabela MedicoTel */
insert into MedicoTel(crm, telefone)
values  ('123355/RN', '(84) 98729-6789'),
		('123566/PB', '(84) 99967-0950');
		
/* Inserindo dados na tabela MedAtendePac */
insert into MedAtendePac(crm, cpf)
values  ('123355/RN', '124.039.223-04'),
		('123355/RN', '125.059.225-05'),
		('123566/PB', '123.049.114-08');
		
/* Inserindo dados na tabela Consulta */
insert into Consulta(cod_cons, prescricao, data_cons, crm)
values  (2, 'Covid-19', '2023-04-23', '123355/RN'),
		(1, 'Crise alérgica', '2023-04-28', '123355/RN'),
		(3, 'Crise alérgica', '2023-05-25', '123566/PB');
		
/* SELECIONANDO DADOS (SELECT) */

/* Retorna todos os dados da tabela Paciente */
select * from Paciente;

/* Retorna o código, a data e valor da tabela Pagamento */
select cod_pag, data_pag, valor from Pagamento; 

/* Retorna prescrição, a data da consulta e o crm do médico ordenados ascendentemente pelo código da consulta */
select prescricao, data_cons, crm from Consulta
order by cod_cons asc;

/* Retorna o crm e o nome do médico ordenados ascendentemente pelo nome */
select crm, nome from Medico
order by nome asc;

/* Retorna os pacientes maiores de idade */
select idade, nome
from Paciente
group by idade, nome
having idade > 18;

/* Seleção dos pagamentos feitos em ordem decrescente */
select distinct valor
from Pagamento
order by valor desc;

/* Seleção dos códigos de consultas e códigos de pagamento */
select cod_cons, prescricao, cod_pag, valor
from Consulta
inner join Pagamento
on cod_cons = cod_pag;

/* Seleção do número de consultas realizadas por cada médico */
select cod_cons, count (cod_cons)
from Consulta
group by cod_cons;

/* SUBCONSULTAS */

/* Seleciona o nome do paciente mais velho */
select nome from Paciente
where idade = (
	select max(idade)
	from Paciente);

/* Retorna o nome do médico que realizou consultas no mês 5 */
select nome from Medico
where crm = (
	select crm from Consulta
	where extract(month from data_cons) = 5);

/* Retorna o nome do paciente cujo valor pago pela consulta foi maior que a média do valores */
select nome from Paciente
where cpf = (
	select cpf from Pagamento 
	where valor > (select avg(valor) from Pagamento));
	
/* Retorna todos os dados dos pacientes cujo valor pago pela consulta foi menor que a média dos valores */
select * from Paciente
where cpf in (
	select cpf from Pagamento
	where valor < (select avg(valor) from Pagamento));

/* Retorna o crm e o nome do médico que realizou mais de uma consulta */
select crm, nome from Medico
where crm = (
	select crm 
	from (
		select crm, count(crm) as cont
		from MedAtendePac
		group by crm) as cont_crm
	where cont > 1);

/* Junta as tabelas Paciente e Pagamento mostrando o nome, o valor e a data de pagamento */
select nome, valor, pag.data_pag 
from Paciente pac
inner join Pagamento pag
on pac.cpf = pag.cpf;

/* ATUALIZANDO DADOS (UPDATE) */

/* Atualização da prescrição e data da consulta cujo cod_cons é igual a 2 */
update Consulta
set prescricao= 'Gripe', data_cons = '2023-04-22'
where cod_cons = 2;

/* Atualizando o telefone do medico cujo crm é 123355/RN */
update MedicoTel
set telefone = '(84) 95369-9513'
where crm = '123355/RN';

/* Atualizando dados do paciente */
update Paciente
set cpf = '124.339.423-05 ', nome = 'Luiz Gonzaga', idade= '27', sexo = 'masculino '
where cpf = '124.039.223-04 ';

/* DELETANDO DADOS (DELETE) */

/* Apagando todos os registros da tabela MedAtendePac */
delete from MedAtendePac;

/* Deletando os dados da tabela Consulta cujo código é 2 e 3 */
delete from Consulta
where cod_cons in (2, 3)
returning *;
