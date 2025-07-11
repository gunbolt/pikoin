module Accounts
  class RecordsController < ApplicationController
    include Pagy::Backend

    def index
      records = account.records
        .includes(:account, :category)
        .order(occurred_on: :desc, created_at: :desc)

      pagy, records = pagy(records)

      render Views::Accounts::Records::Index.new(account:, records:, pagy:)
    end

    def new
      result = Records::BuildFromParams.call(
        account: account,
        params: params.permit(:group, :template).to_h.symbolize_keys
      )
      record = result.record

      render Views::Accounts::Records::New.new(record:, accounts:, categories:)
    end

    def edit
      authorize_record!

      record = account.records.without_transfers.find(params[:id])

      render Views::Accounts::Records::Edit.new(
        account:, record:, accounts:, categories:
      )
    end

    def create
      case Records::Create.call(attributes: record_params)
      in Records::Create::Success
        redirect_to account_records_path(account),
          notice: t("Record created")
      in Records::Create::Failure(record)
        render Views::Accounts::Records::New.new(
          record:, accounts:, categories:
        ), status: :unprocessable_entity
      end
    end

    def update
      authorize_record!

      case Records::Update.call(id: params[:id], attributes: record_params)
      in Records::Update::Success
        redirect_to account_records_path(account), notice: t("Record updated")
      in Records::Update::Failure(record)
        render Views::Accounts::Records::Edit.new(
          account:, record:, accounts:, categories:
        ), status: :unprocessable_entity
      end
    end

    def destroy
      authorize_record!

      case Records::Destroy.call(id: params[:id])
      in Records::Destroy::Success
        redirect_to account_records_path(account), notice: t("Record removed")
      end
    end

    private

    def account
      @account ||= Account.find(params[:account_id])
    end

    def accounts = Account.active.order(:position)

    def categories = Category.order(:position)

    def record_params
      params.expect(
        record: %i[group account_id category_id amount_cents occurred_on note]
      )
    end

    # Records generated by transfers should not be updated/deleted directly.
    # It should be done via transfer.
    def authorize_record!
      if Record.without_transfers.where(id: params[:id]).none?
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
