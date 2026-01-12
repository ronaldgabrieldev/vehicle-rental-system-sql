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