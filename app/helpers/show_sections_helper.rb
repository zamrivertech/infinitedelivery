# app/helpers/show_sections_helper.rb
module ShowSectionsHelper
  def entity_sections(entity)
    {
      "Informações Pessoais" => [
        ["Nome Completo", entity.full_name],
        ["Género", entity.gender],
        ["Data de Nascimento", entity.date_of_birth&.then { l(_1, format: :long) }],
        ["Local de Nascimento", entity.place_of_birth],
        ["Nacionalidade", entity.nationality],
        ["Estado Civil", entity.marital_status],
        ["Altura", entity.height_cm&.then { "#{_1} cm" }]
      ],

      "Identificação" => [
        ["Tipo de Identificação", entity.id_type],
        ["Número de Identificação", entity.id_number],
        ["País de Emissão", entity.issuance_country],
        ["Local de Emissão", entity.issuance_location],
        ["Data de Emissão", entity.issuance_date&.then { l(_1, format: :long) }],
        ["Data de Validade", entity.expiry_date&.then { l(_1, format: :long) }],
        ["Função", entity.role&.name&.titleize]
      ],

      "Contactos" => [
        ["Lista", render_contacts(entity.contacts)]
      ],

      "Endereços" => [
        ["Lista", render_addresses(entity.addresses)]
      ]
    }
  end

  def entities_roles_sections(role)
    {
      "Detalhes do Papel" => [
        ["Nome", role.name],
        ["Grupo", role.role_group],
        ["Descrição", role.description]
      ]
    }
  end

  def render_contacts(contacts)
    return "—" if contacts.blank?

    content_tag(:ul, class: "list-unstyled mb-0") do
      contacts.select { |c| c.contact_type.present? && c.value.present? }.map do |contact|
        content_tag(:li, "#{contact.contact_type.titleize}: #{contact.value}")
      end.join.html_safe
    end
  end

  def render_addresses(addresses)
    return "—" if addresses.blank?

    safe_join(
    addresses.map do |address|
      content_tag(:div, class: "mb-0") do
        safe_join([
          content_tag(:strong, "Tipo:") + " #{address.address_type}",
          content_tag(:strong, "Rua:") + " #{address.street_line_1}",
          (address.street_line_2.present? ? address.street_line_2 : nil),
          content_tag(:strong, "Bairro/Distrito:") + " #{[address.neighborhood, address.city].compact.join(', ')}",
          content_tag(:strong, "Região:") + " #{[address.region, address.postal_code].compact.join(', ')}",
          content_tag(:strong, "País:") + " #{address.country}"
        ].compact, tag(:br))
      end
    end
  )
  end
end
