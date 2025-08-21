class CategoriesController < ApplicationController
  def index
    categories = Category.order(:position)

    render Views::Categories::Index.new(categories:)
  end

  def new
    category = Category.new

    render Views::Categories::New.new(category:)
  end

  def edit
    category = Category.find(params[:id])

    render Views::Categories::Edit.new(category:)
  end

  def create
    case Categories::Create.call(attributes: category_params)
    in Categories::Create::Success
      redirect_to categories_path, notice: t("Category created")
    in Categories::Create::Failure(category)
      render Views::Categories::New.new(category:), status: :unprocessable_content
    end
  end

  def update
    case Categories::Update.call(id: params[:id], attributes: category_params)
    in Categories::Update::Success
      redirect_to categories_path, notice: t("Category updated")
    in Categories::Update::Failure(category)
      render Views::Categories::Edit.new(category:), status: :unprocessable_content
    end
  end

  def destroy
    case Categories::Destroy.call(id: params[:id])
    in Categories::Destroy::Success
      redirect_to categories_path, notice: t("Category removed")
    end
  end

  private

  def category_params
    params.expect(category: %i[title color])
  end
end
