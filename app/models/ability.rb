class Ability
  include CanCan::Ability

  # Quando alguém acessa uma página do sistema, a classe ability sempre vai rodar primeiro 
  # o método initialize abaixo. Nele está sendo passado um parâmetro user.
  def initialize(user)
    if user #primeiro já é verificado se quem está tentando acessar o sistema é um objeto user
      if user.kind == 'salesman' #verifica o tipo de usuário
        can :access, :rails_admin #pode acessar o admin
        can :dashboard #pode acessar o dashboard
        can :manage, Client, user_id: user.id #pode gerenciar os clientes se forem clientes deste vendedor. O parâmetro user_id: user.id garante que este vendedor só pode ver os seus clientes. Ou seja, ele não pode ver os clientes de outros vendedores.
        can :manage, Sale, user_id: user.id #pode gerenciar as vendas se forem vendas deste vendedor
        can :read, Product, status: :active #o vendedor só pode ler os produtos que estão ativos. Quem faz esse gerenciamento é o gerente e não o vendedor. Por isso, o nível de acesso do vendedor é de leitura.
        can :read, Discount, status: :active
        can :read, Comission, user_id: user.id
        can :manage, ProductQuantity, user_id: user.id
        can :manage, Address, user_id: user.id
      elsif user.kind == 'manager'
        can :manage, :all
      end
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities



  end
end
