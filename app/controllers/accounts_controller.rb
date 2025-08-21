class AccountsController < ApplicationController
  def index
    accounts = Account.order(:position)

    render Views::Accounts::Index.new(accounts:)
  end

  def new
    account = Account.new

    render Views::Accounts::New.new(account:)
  end

  def edit
    account = Account.find(params[:id])

    render Views::Accounts::Edit.new(account:)
  end

  def create
    case Accounts::Create.call(attributes: account_params)
    in Accounts::Create::Success
      redirect_to accounts_path, notice: t("Account created")
    in Accounts::Create::Failure(account)
      render Views::Accounts::New.new(account:), status: :unprocessable_content
    end
  end

  def update
    case Accounts::Update.call(id: params[:id], attributes: account_params)
    in Accounts::Update::Success(account)
      redirect_to account_records_path(account), notice: t("Account updated")
    in Accounts::Update::Failure(account)
      render Views::Accounts::Edit.new(account:), status: :unprocessable_content
    end
  end

  def destroy
    case Accounts::Destroy.call(id: params[:id])
    in Accounts::Destroy::Success
      redirect_to accounts_path, notice: t("Account removed")
    end
  end

  private

  def account_params
    params.expect(account: %i[title color initial_amount_cents archived])
  end
end
