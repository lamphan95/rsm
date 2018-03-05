Rails.application.config.assets.version = "1.0"
Rails.application.config.assets.paths << Rails.root.join("node_modules")
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.svg *.ico *.eot *.ttf)
Rails.application.config.assets.precompile += %w(devise_users/devise_user.css jobs/job.css)
Rails.application.config.assets.precompile += %w(companies/company.css companies/language-selector.css)
Rails.application.config.assets.precompile += %w(format_datepicker.js company.js load_image.js)
Rails.application.config.assets.precompile += %w(employers/employer.css companies/f-style.css)
Rails.application.config.assets.precompile += %w(employer.js jquery.form.min.js companies/icon.css)
Rails.application.config.assets.precompile += %w(ckeditor/filebrowser/images/gal_del.png choose_file.js)
Rails.application.config.assets.precompile += %w(mailer.css job.js app.js jobs/job.css jobs/job_show.css)
Rails.application.config.assets.precompile += %w(employer/plugins.js employer/app.js employers/search.js)
Rails.application.config.assets.precompile += %w(translate.js downloads/downloads.css downloads/cv.css)
Rails.application.config.assets.precompile += %w(selectboxit/src/javascripts/jquery.selectBoxIt.js)
Rails.application.config.assets.precompile += %w(selectboxit/custom_selectboxit.js profile.js)
Rails.application.config.assets.precompile += %w(employers/edit_companies.css employer/checkbox.css)
Rails.application.config.assets.precompile += %w(employers/notification.scss employer/hidepaginate.css)
Rails.application.config.assets.precompile += %w(company/login.js survey.js employers/apply_block.js)
Rails.application.config.assets.precompile += %w(employers/calendar.js compCalendar.js employers/validate.js)
Rails.application.config.assets.precompile += %w(read_notification.scss custom_height_layout.js)
Rails.application.config.assets.precompile += %w(employer/jquery-ui.css employers/select_step.js survey.scss
  employers/search_question.js employers/choose_question.js employers/sidebar_employer.js)
