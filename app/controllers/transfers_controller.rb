class TransfersController < ApplicationController
  def new
    account = Account.find(params[:account_id])
    transfer = Transfer.new(
      from_account: account,
      to_account: account,
      occurred_on: Time.zone.today
    )

    render Views::Transfers::New.new(transfer:, accounts:)
  end

  def edit
    transfer = Transfer.find(params[:id])

    render Views::Transfers::Edit.new(transfer:, accounts:)
  end

  def create
    case Transfers::Create.call(attributes: transfer_params)
    in Transfers::Create::Success
      redirect_to account_records_path(params[:account_id]),
        notice: t("Transfer created")
    in Transfers::Create::Failure(transfer)
      render Views::Transfers::New.new(transfer:, accounts:),
        status: :unprocessable_content
    end
  end

  def update
    case Transfers::Update.call(id: params[:id], attributes: transfer_params)
    in Transfers::Update::Success
      redirect_to account_records_path(params[:account_id]),
        notice: t("Transfer updated")
    in Transfers::Update::Failure(transfer)
      render Views::Transfers::Edit.new(transfer:, accounts:),
        status: :unprocessable_content
    end
  end

  def destroy
    case Transfers::Destroy.call(id: params[:id])
    in Transfers::Destroy::Success
      redirect_to account_records_path(params[:account_id]),
        notice: t("Transfer removed")
    end
  end

  private

  def transfer_params
    params.expect(
      transfer: %i[from_account_id to_account_id amount_cents occurred_on note]
    ).to_h
  end

  def accounts = Account.active.order(:position)
end
