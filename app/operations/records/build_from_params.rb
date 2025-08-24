module Records
  class BuildFromParams < ApplicationOperation
    prop :account, Account
    prop :params, Hash

    Result = Result.define(record: Record)

    def call
      record = case @params
      in group: String => group
        build_from_group(group)
      in template: String => template_id
        build_from_template(template_id)
      else
        Record.new
      end

      record.account ||= @account
      record.occurred_on = Time.zone.today

      Result[record:]
    end

    private

    def build_from_group(group)
      if group == "expense"
        Record.new(group: :expense)
      elsif group == "income"
        Record.new(group: :income)
      end
    end

    def build_from_template(template_id)
      template = Template.find(template_id)

      Record.new(
        group: template.group,
        account_id: template.account_id,
        category_id: template.category_id,
        amount_cents: template.amount_cents,
        note: template.note.presence || template.title
      )
    end
  end
end
