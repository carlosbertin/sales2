# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Criando nossos Users --- OBS: Depois que adicionarmos o devise precisamos incluir o email e senha dos users
User.create name: 'José', status: :active, kind: :salesman, email: 'salesman@teste.com', password: 123456
User.create name: 'Maria', status: :active, kind: :salesman, email: 'salesman2@teste.com', password: 123456
User.create name: 'Marcos', status: :active, kind: :salesman, email: 'salesman3@teste.com', password: 123456
User.create name: 'Juliana', status: :active, kind: :manager, email: 'manager@teste.com', password: 123456

# Criando alguns produtos de exemplo
Product.create name: 'Smartphone', description:'Um smartphone novo ...', status: :active, price: 1000
Product.create name: 'Tablet', description:'Um tablet novo ...', status: :active, price: 2000
Product.create name: 'Teclado', description: 'Um teclado novo ...', status: :active, price: 150
Product.create name: 'Notebook', description: 'Um notebook novo ...', status: :active, price: 3500

# Criando um desconto de exemplo
Discount.create name: 'Desconto carnaval', description: 'Aplique esse desconto no carnaval', value: '10', kind: :porcent, status: :active
Discount.create name: 'Desconto carnaval dinheiro', description: 'Aplique esse desconto de carnaval em dinheiro', value: '15', kind: :money, status: :active

# Criando clientes
Client.create name: 'João', company_name: 'Google', document: '123', email: 'joao@gmail.com', user: User.first
Client.create name: 'Julia', company_name: 'IBM', document: 'abc', email: 'julia@ibm.com', user: User.first