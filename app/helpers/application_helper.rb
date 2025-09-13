# app/helpers/application_helper.rb
module ApplicationHelper
  def booking_status_badge(status)
    case status
    when 'confirmed'
      'success'
    when 'pending'
      'warning'
    when 'canceled', 'rejected'
      'danger'
    else
      'secondary'
    end
  end

  def booking_status_text(status)
    case status
    when 'confirmed'
      'مؤكد'
    when 'pending'
      'قيد الانتظار'
    when 'canceled'
      'ملغى'
    when 'rejected'
      'مرفوض'
    else
      status
    end
  end
end
