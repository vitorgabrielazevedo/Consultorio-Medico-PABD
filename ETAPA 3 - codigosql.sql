create table cm.Paciente(
	cpf varchar(15) primary key,
	nome text not null,
	idade int not null,
	sexo varchar(15) not null
);    

create table cm.PacienteTel(
	cpf varchar(15) references cm.Paciente(cpf),
	telefone varchar(20) not null
);

create table cm.Pagamento(
	cod_pag int primary key,
	data_pag date not null,
	valor decimal not null,
	cpf varchar(15) references cm.Paciente(cpf)
);

create table cm.Medico(
	crm varchar(15) primary key,
	nome text not null
);

create table cm.MedicoTel(
	crm varchar(15) references cm.Medico(crm),
	telefone varchar(20) not null
);

create table cm.MedAtendePac(
	cpf varchar(15) references cm.Paciente(cpf),
	crm varchar(15) references cm.Medico(crm)
);

create table cm.Consulta(
	cod_cons int primary key,
	prescricao text not null,
	data_cons date not null,
	crm varchar(15) references cm.Medico(crm)
);

select * from cm.Paciente, cm.PacienteTel, cm.Pagamento, cm.Medico, cm.MedicoTel, cm.MedAtendePac, cm.Consulta

