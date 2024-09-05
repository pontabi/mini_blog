module UserHelper
  FA_SNS_ICON_CLASSES = {
    instagram: "square-instagram",
    x: "square-x-twitter",
    facebook: "square-facebook",
    youtube: "square-youtube",
    linkedin: "linkedin",
    github: "square-github"
  }.freeze

  def self_user?(user)
    user_signed_in? && current_user == user
  end

  def current_user?(user)
    current_user == user
  end

  def sns_icon_link(blog)
    icon_class = sns_icon_class(blog)
    link_to blog.url, target: "_blank", rel: "noopener" do
      icon_class ? icon("fa-brands", icon_class + " fa-lg", class: "sns-icon") : icon("fa-solid", "up-right-from-square", class: "sns-icon")
    end
  end

  def sns_icon_class(blog)
    FA_SNS_ICON_CLASSES[blog.kind.downcase.to_sym]
  end
end
