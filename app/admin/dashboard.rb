ActiveAdmin.register_page 'Dashboard' do

  menu priority: 1
  content title: proc { I18n.t('active_admin.dashboard') } do

    columns do
      column do
        panel 'Recent Registrations' do
          table_for User.all.order('created_at desc').limit(10) do
            column(:is_artist)  { |user| status_tag(user.is_artist) }
            column(:name)       { |user| link_to(user.name, user_path(user.id)) }
            column(:created) { |user| time_ago_in_words(user.created_at) + ' ago' }
          end
        end
      end

      column do
        panel 'Reported Reviews' do
          table_for Review.where(reported: true).limit(10).each do |review|
            column(:receiving_user)   { |review| link_to(review.receiving_user.name, admin_user_path(review.receiving_user.id)) }
            column(:leaving_user)     { |review| link_to(review.leaving_user.name, admin_user_path(review.leaving_user.id)) }
            column(:comment)          { |review| review.comment }
            column(:upvotes)          { |review| review.upvotes }
          end
        end
      end
    end # columns

    columns do
      column do
        div do
          br
          text_node %{<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB"
                              width="500" height="300" scrolling="no" frameborder="no">
                      </iframe>}.html_safe
        end
      end
    end # columns

    # Define your dashboard sections here. Each block will be
    # rendered on the dashboard in the context of the view. So just
    # return the content which you would like to display.

    # The dashboard is organized in rows and columns, where each row
    # divides the space for its child columns equally.

    # To start a new row, open a new 'columns' block, and to start a
    # new column, open a new 'colum' block. That way, you can exactly
    # define the position for each content div.

    # == Simple Dashboard Column
    # Here is an example of a simple dashboard column
    #
    #   column do
    #     panel "Recent Posts" do
    #       content_tag :ul do
    #         Post.recent(5).collect do |post|
    #           content_tag(:li, link_to(post.title, admin_post_path(post)))
    #         end.join.html_safe
    #       end
    #     end
    #   end

    # == Render Partials
    # The block is rendererd within the context of the view, so you can
    # easily render a partial rather than build content in ruby.
    #
    #   column do
    #     panel "Recent Posts" do
    #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
    #     end
    #   end
  end # content
end