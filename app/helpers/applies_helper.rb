module AppliesHelper
  def get_data appointments, apply
    content_tag "div", "", id: "apply-appointments", data: {events: appointments, name: get_name_to(apply)}
  end

  def get_name_to apply
    apply.information[:name] || ''
  end

  def cv_update_at user
    "(#{t ".update"} #{l current_user.updated_at, format: :date_time})"
  end

  def check_show_job_exception job
    if job.exception?
      content_tag "span", class: "label label-danger font-size-14" do
        job.name
      end
    else
      job.name
    end
  end

  def get_link_job_exception apply
    if apply.job.exception?
      link_to employers_job_apply_path(apply.job, id: apply.id), class: "btn btn-default btn-xs" do
        content_tag "i", "", class: "fa fa-eye"
      end
    else
      link_to employers_apply_status_path(apply.apply_statuses.current.first),
        remote: true, class: "btn btn-default btn-xs" do
        content_tag "i", "", class: "fa fa-eye"
      end
    end
  end
end
