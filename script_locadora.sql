create database locadoraVeiculos;    
use locadoraVeiculos; 
create table Cliente( 
idCliente int primary key not null, 
CPF varchar (20) not null, 
nome varchar (50) not null, 
telefone varchar (20) not null, 
email varchar (50) not null, 
endereco varchar (100) not null 
); 
create table Pagamento ( 
idPagamento int primary key not null, 
forma enum ('Cartão', 'Pix', 'Dinheiro') not null, 
dataPagamento date not null, 
valorTotal decimal (7,2) not null, 
estado enum ('Pago','Pendente') not null 
); 
create table Veiculo( 
idVeiculo int primary key not null, 
modelo varchar (50) not null, 
marca varchar (50) not null, 
ano int not null, 
placa varchar (10) not null, 
valorDiaria decimal (7,2) not null, 
estado enum ('Disponível', 'Alugado', 'Manutenção') not null 
); 
create table Locacao ( 
idLocacao int primary key not null, 
idCliente int not null, 
idPagamento int not null, 
foreign key (idCliente) references Cliente (idCliente), 
foreign key (idPagamento) references Pagamento (idPagamento), 
dataInicio date not null, 
dataFim date not null 
); 
create table Manutencao ( 
idManutencao int primary key not null, 
idVeiculo int not null, 
foreign key (idVeiculo) references Veiculo (idVeiculo), 
descricao varchar (100) not null, 
dataManutencao date not null, 
custo decimal (7,2) 
); 
create table LocacaoVeiculo ( 
idLocacao int not null, 
idVeiculo int not null, 
foreign key (idLocacao) references Locacao (idLocacao), 
foreign key (idVeiculo) references Veiculo (idVeiculo)
);
select descricao, dataManutencao as 'Data', custo 
from Manutencao;
select sum(valorTotal) as 'Valor Arrecadado' from Pagamento where estado = 'Pago';
select  
V.modelo, 
V.marca, 
count(LV.idLocacao) as numero_locacoes 
from  
Veiculo V 
left join  
LocacaoVeiculo LV on V.idVeiculo = LV.idVeiculo 
group by 
V.idVeiculo, V.modelo, V.marca 
order by  
numero_locacoes desc;
select  
c.nome as cliente, 
SUM(p.valorTotal) as 'Valor Devido' 
from  
Cliente c 
join  
Locacao l on c.idCliente = l.idCliente 
join  
Pagamento p on l.idPagamento = p.idPagamento 
where  
p.estado = 'Pendente' 
group by  
c.idCliente, c.nome 
order by  
c.nome ASC;
INSERT INTO Cliente VALUES
(1, '111.111.111-11', 'João da Silva', '9999-1111', 'joao@email.com', 'Rua A'),
(2, '222.222.222-22', 'Lucas Martins', '9999-2222', 'lucas@email.com', 'Rua B'),
(3, '333.333.333-33', 'Pedro dos Santos', '9999-3333', 'pedro@email.com', 'Rua C'),
(4, '444.444.444-44', 'Ana Pereira', '9999-4444', 'ana@email.com', 'Rua D'),
(5, '555.555.555-55', 'Carlos Eduardo', '9999-5555', 'carlos@email.com', 'Rua E'),
(6, '666.666.666-66', 'Mariana Lopes', '9999-6666', 'mariana@email.com', 'Rua F');
INSERT INTO Pagamento VALUES
(1, 'Cartão', '2024-12-05', 880.00, 'Pendente'),
(2, 'Pix', '2024-12-10', 2220.00, 'Pendente'),
(3, 'Dinheiro', '2024-12-15', 280.00, 'Pendente'),
(4, 'Cartão', '2024-12-20', 5000.00, 'Pago'),
(5, 'Pix', '2024-12-25', 9700.00, 'Pago'),
(6, 'Pix', '2025-02-01', 1350.00, 'Pago'),
(7, 'Cartão', '2025-02-03', 920.00, 'Pendente'),
(8, 'Dinheiro', '2025-02-05', 1600.00, 'Pago'),
(9, 'Pix', '2025-02-06', 450.00, 'Pendente');
INSERT INTO Veiculo VALUES
(1, 'HB20', 'Hyundai', 2022, 'AAA-1111', 150.00, 'Disponível'),
(2, 'Duster', 'Renault', 2021, 'BBB-2222', 180.00, 'Disponível'),
(3, 'Gol', 'Volkswagen', 2020, 'CCC-3333', 120.00, 'Disponível'),
(4, 'Corolla', 'Toyota', 2023, 'DDD-4444', 250.00, 'Disponível'),
(5, 'Fiesta', 'Ford', 2019, 'EEE-5555', 130.00, 'Disponível'),
(6, 'Toro', 'Fiat', 2022, 'FFF-6666', 200.00, 'Disponível'),
(7, 'Compass', 'Jeep', 2023, 'GGG-7777', 270.00, 'Disponível'),
(8, 'Onix', 'Chevrolet', 2021, 'HHH-8888', 140.00, 'Disponível'),
(9, 'Civic', 'Honda', 2020, 'III-9999', 240.00, 'Disponível'),
(10, 'Cruze', 'Chevrolet', 2021, 'JJJ-0000', 160.00, 'Disponível');
INSERT INTO Locacao VALUES
(1, 1, 1, '2024-12-01', '2024-12-05'),
(2, 2, 2, '2024-12-06', '2024-12-10'),
(3, 3, 3, '2024-12-11', '2024-12-12'),
(4, 1, 4, '2024-12-13', '2024-12-20'),
(5, 2, 5, '2024-12-21', '2024-12-28'),
(6, 4, 6, '2025-02-01', '2025-02-05'),
(7, 5, 7, '2025-02-03', '2025-02-06'),
(8, 6, 8, '2025-02-05', '2025-02-10'),
(9, 1, 9, '2025-02-06', '2025-02-07');
INSERT INTO LocacaoVeiculo VALUES
(1,1),(2,1),(3,1),(4,1),
(1,2),(2,2),(3,2),
(1,3),(2,3),
(1,4),(2,4),
(1,5),(2,5),
(1,6),(2,6),
(1,7),(2,7),
(1,8),
(1,9),
(1,10),
(6,1),
(6,2),
(7,3),
(7,4),
(8,5),
(8,6),
(9,7);
INSERT INTO Manutencao VALUES
(1,1,'Troca de óleo e revisão geral','2024-12-09',200.00),
(2,2,'Substituição de pneu','2024-12-10',600.00),
(3,3,'Troca de pastilhas de freio','2024-12-14',450.00),
(4,4,'Alinhamento e balanceamento','2024-12-18',150.00),
(5,5,'Revisão elétrica completa','2024-12-28',500.00),
(6,6,'Reparo na suspensão','2025-01-05',700.00),
(7,7,'Troca do sistema de escapamento','2025-01-07',750.00),
(8,8,'Troca de bateria','2025-01-17',400.00),
(9,9,'Substituição do filtro de ar','2025-01-17',120.00),
(10,10,'Pintura e retoques na lataria','2025-01-28',900.00),
(11,3,'Troca de amortecedores','2025-02-02',800.00),
(12,4,'Revisão do sistema de freios','2025-02-04',650.00),
(13,6,'Troca de correia dentada','2025-02-06',900.00),
(14,7,'Diagnóstico eletrônico','2025-02-08',300.00);
