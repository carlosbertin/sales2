RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  # Abaixo está sendo a customização dos formulários padrões da gem rails_admin.
  # Assim, alguns campos que precisam ser omitidos ou acrescentados, serão customizados a seguir.

  # No modelo Sale, action create, será mostrado apenas os campos abaixo na view.
  config.model Sale do
    create do
      field  :client
      field  :sale_date
      field  :discount
      field  :notes
      field  :product_quantities
   
      # As linhas abaixo servem para omitir o campo id do usuario e cadastrar o id do usuário corrente.
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
   
    
    edit do # Esta linha indica que será personalizado o form Edit do Sale (da venda)
      field  :client
      field  :sale_date
      field  :discount
      field  :notes
      field  :product_quantities
   
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
  end
   
  config.model Client do
    create do
      field  :name
      field  :company_name
      field  :document
      field  :email
      field  :phone
      field  :notes
      field  :status
      field  :address
   
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
   
    edit do
      field  :name
      field  :company_name
      field  :document
      field  :email
      field  :phone
      field  :notes
      field  :status
      field  :address   
   
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
   
    list do
      field  :name
      field  :company_name
      field  :document
      field  :email
      field  :phone
      field  :notes
      field  :status
      field  :address
    end
  end

  config.model Product do
    create do
      field  :name
      field  :description
      field  :status
      field  :price
      field  :photo
    end
   
    edit do
      field  :name
      field  :description
      field  :status
      field  :price
      field  :photo
    end
   
    show do
      field  :name
      field  :description
      field  :status
      field  :price
      field  :photo
    end

    list do
      field  :name
      field  :description
      field  :status
      field  :price
      field  :photo
    end
  end
   
  # a linha abaixo serve para omitir o menu lateral esquerdo (Product quantities)
  config.model ProductQuantity do
    visible false
  end
  
  # a linha abaixo serve para omitir o menu lateral esquerdo (Address)
  config.model Address do
    visible false
  end

  # as linhas abaixo servem para, no pop up das vendas e mostrar apenas os campos product, quantity e esconder o usuário corrente
  config.model ProductQuantity do
    edit do
      field :product
      field :quantity
   
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
  end



  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
