class TemplatesController < ApplicationController
  def index
    templates = Template.order(:position)

    render Views::Templates::Index.new(templates:)
  end

  def new
    template = Template.new

    render Views::Templates::New.new(template:, accounts:, categories:)
  end

  def edit
    template = Template.find(params[:id])

    render Views::Templates::Edit.new(template:, accounts:, categories:)
  end

  def create
    case Templates::Create.call(attributes: template_params)
    in Templates::Create::Success
      redirect_to templates_path, notice: t("Template created")
    in Templates::Create::Failure(template)
      render Views::Templates::New.new(template:, accounts:, categories:),
        status: :unprocessable_content
    end
  end

  def update
    case Templates::Update.call(id: params[:id], attributes: template_params)
    in Templates::Update::Success
      redirect_to templates_path, notice: t("Template updated")
    in Templates::Update::Failure(template)
      render Views::Templates::Edit.new(template:, accounts:, categories:),
        status: :unprocessable_content
    end
  end

  def destroy
    case Templates::Destroy.call(id: params[:id])
    in Templates::Destroy::Success
      redirect_to templates_path, notice: t("Template removed")
    end
  end

  private

  def template_params
    params.expect(
      template: %i[title group account_id category_id amount_cents note]
    )
  end

  def accounts = Account.active.order(:position)

  def categories = Category.order(:position)
end
