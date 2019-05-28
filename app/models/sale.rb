class Sale < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :discount
  has_many :product_quantities
  has_one :comission


  # Callback: método que será chamado todas as vezes que esta classe sofrer alguma ação.
  # Neste caso, este callback é do tipo after_save. Ou seja, este callback será chamado
  # todas as vezes que este classe sofrer uma ação de save. Existem outros tipos de 
  # callbacks, como por exemplo o before_save, que faria uma ação antes de salvar.
  # Outros exemplos de callbacks: before_create, before_update, after_update... e etc.
  after_save do
    calc = 0
    # Soma o preço dos produtos vezes a quantidade deles. A linha self.product_quantities
    # pega cada sale (venda) da tabela ProductQuantity de um cliente do usuário (vendedor) corrente
    # Ou seja, a venda 1 (do usuário/vendedor José) tem N ProductQuantity (vendidos para o cliente João)
    self.product_quantities.each {|p| calc += p.product.price * p.quantity}
    # Verifica se existe um desconto e aplica caso exista
    if self.discount # Se existe desconto para esta venda... Na vdd aqui está verificando se existe uma ocorrência nesta associação (belongs_to :discount)
      if self.discount.kind == 'porcent' # verifica o tipo (kind - atributo da classe discount) é porcent ou money
        calc -= calc / self.discount.value
      elsif self.discount.kind == 'money'
        calc -= self.discount.value
      end
    end

    # Verifica se já existe uma comissão associada a esta venda, caso sim, atualiza, caso não, cria uma nova. 
    if self.comission.present? # Verifica se existe uma ocorrência nesta associação (has_one :comission)
      self.comission.update(value: (calc * 0.1), status: :pending) # Se já existe, faz update da comissão já existente
      
      # self.comission.update(value: calc * self.user.comission, status: :pending)
      # No nosso exemplo, cada vendedor recebe 10% de comissão. Porém, na linha comentada acima,
      # o comando: calc * self.user.comission serveria para calcular uma comissão
      # diferenciada para o usuário corrente (logado). 
    else
      Comission.create(value: (calc * 0.1), user: self.user, sale: self, status: :pending)
    end
    
  end
end