# app/helpers/form_fields_helper.rb
module FormFieldsHelper
  def merge_select_classes(html_opts, form:, attr:)
    html_opts ||= {}
    html_opts[:class] = [
      html_opts[:class],
      "form-select",
      ("select2" if html_opts.delete(:select2)),
      ("is-invalid" if form.object.errors[attr].any?)
    ].compact.join(" ")
    html_opts
  end

  def entity_personal_fields
    [
      field(:full_name, :text_field, "Nome Completo"),
      field(:gender, :select, "Gênero", ["Masculino", "Feminino", "Outro"], class: "form-select"),
      field(:date_of_birth, :date_field, "Data de Nascimento"),
      field(:nationality, :select, "Nacionalidade", COUNTRIES, select2: true),
      field(:place_of_birth, :text_field, "Naturalidade"),
      field(:marital_status, :select, "Estado Civil", ["Solteiro", "Casado", "Divorciado"]),
      field(:height_cm, :number_field, "Altura (cm)")
    ]
  end

  def entity_identification_fields
    [
      field(:role_id, :collection_select, "Tipo de Entidade", Role.all, :id, :name),
      field(:id_type, :select, "Tipo de Identificação", ["Passaporte", "Bilhete de Identidade", "NUIT", "Recenseamento Eleitoral"]),
      field(:id_number, :text_field, "Número de Identificação"),
      field(:issuance_country, :text_field, "País de Emissão"),
      field(:issuance_location, :text_field, "Local de Emissão"),
      field(:issuance_date, :date_field, "Data de Emissão"),
      field(:expiry_date, :date_field, "Data de Validade")
    ]
  end

def address_fields
  mozambique_provinces = MOZAMBIQUE_POSTAL_CODE_RANGES.map do |name, range|
    "#{name}"
  end

  [
    field(:address_type, :select, "Tipo de Endereço", ["Residencial", "Comercial"]),
    field(:street_line_1, :text_field, "Rua / Avenida"),
    field(:street_line_2, :text_field, "Complemento"),
    field(:neighborhood, :text_field, "Bairro"),
    field(:city, :text_field, "Cidade / Distrito"),
    field(:region, :select, "Província / Região", mozambique_provinces),
    field(:postal_code, :text_field, "Código Postal", placeholder: "Ex: 1200–1219"),
    field(:country, :select, "País", ["Moçambique"])
  ]
end




 def contact_fields
  [
    field(:contact_type, :select, "Tipo de Contato", ["Telefone", "Email", "Outro"]),
    field(:value, :text_field, "Valor do Contato")
  ]      
 end

  def render_fields(form, fields)
    fields.map do |attr, type, label, *args|
      field_html = case type
      when :select
        html_opts = args[1] || {}
        form.label(attr, label, class: "form-label") +
        form.select(attr, args[0], { prompt: "Escolher..." }, merge_select_classes(html_opts, form: form, attr: attr))
      when :collection_select
        form.label(attr, label, class: "form-label") +
        form.collection_select(attr, args[0], args[1], args[2], { prompt: "Escolher..." }, merge_select_classes(args[3], form: form, attr: attr))
      else
        form.label(attr, label, class: "form-label") +
        form.send(type, attr, class: "form-control #{'is-invalid' if form.object.errors[attr].any?}")
      end

      content_tag(:div, field_html + validation_feedback(form.object, attr), class: "mb-3")
    end.join.html_safe
  end


      

  private

  def field(attr, type, label, *args, **html_opts)
    case type
    when :select
      html_opts[:prompt] ||= "Escolher..."
      [attr, type, label, args.first, html_opts]
    when :collection_select
      [attr, type, label, *args, html_opts]
    else
      [attr, type, label]
    end
  end
end
