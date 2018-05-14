const RoutesDump = `
                            root GET    /                                                                                        application#index
                           about GET    /about(.:format)                                                                         application#about
                        redirect GET    /redirect/:monitor_id(.:format)                                                          redirects#redirect
                new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
                    user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
            destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
               new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
              edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
                   user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
                                 PUT    /users/password(.:format)                                                                devise/passwords#update
                                 POST   /users/password(.:format)                                                                devise/passwords#create
        cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
           new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
          edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
               user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
                                 PUT    /users(.:format)                                                                         devise/registrations#update
                                 DELETE /users(.:format)                                                                         devise/registrations#destroy
                                 POST   /users(.:format)                                                                         devise/registrations#create
                     admin_users GET    /admin/users(.:format)                                                                   admin/users#index
                                 POST   /admin/users(.:format)                                                                   admin/users#create
                  new_admin_user GET    /admin/users/new(.:format)                                                               admin/users#new
                 edit_admin_user GET    /admin/users/:id/edit(.:format)                                                          admin/users#edit
                      admin_user GET    /admin/users/:id(.:format)                                                               admin/users#show
                                 PATCH  /admin/users/:id(.:format)                                                               admin/users#update
                                 PUT    /admin/users/:id(.:format)                                                               admin/users#update
                                 DELETE /admin/users/:id(.:format)                                                               admin/users#destroy
              admin_app_monitors GET    /admin/app_monitors(.:format)                                                            admin/app_monitors#index
                                 POST   /admin/app_monitors(.:format)                                                            admin/app_monitors#create
           new_admin_app_monitor GET    /admin/app_monitors/new(.:format)                                                        admin/app_monitors#new
          edit_admin_app_monitor GET    /admin/app_monitors/:id/edit(.:format)                                                   admin/app_monitors#edit
               admin_app_monitor GET    /admin/app_monitors/:id(.:format)                                                        admin/app_monitors#show
                                 PATCH  /admin/app_monitors/:id(.:format)                                                        admin/app_monitors#update
                                 PUT    /admin/app_monitors/:id(.:format)                                                        admin/app_monitors#update
                                 DELETE /admin/app_monitors/:id(.:format)                                                        admin/app_monitors#destroy
           admin_monitor_results GET    /admin/monitor_results(.:format)                                                         admin/monitor_results#index
                                 POST   /admin/monitor_results(.:format)                                                         admin/monitor_results#create
        new_admin_monitor_result GET    /admin/monitor_results/new(.:format)                                                     admin/monitor_results#new
       edit_admin_monitor_result GET    /admin/monitor_results/:id/edit(.:format)                                                admin/monitor_results#edit
            admin_monitor_result GET    /admin/monitor_results/:id(.:format)                                                     admin/monitor_results#show
                                 PATCH  /admin/monitor_results/:id(.:format)                                                     admin/monitor_results#update
                                 PUT    /admin/monitor_results/:id(.:format)                                                     admin/monitor_results#update
                                 DELETE /admin/monitor_results/:id(.:format)                                                     admin/monitor_results#destroy
             admin_notifications GET    /admin/notifications(.:format)                                                           admin/notifications#index
                                 POST   /admin/notifications(.:format)                                                           admin/notifications#create
          new_admin_notification GET    /admin/notifications/new(.:format)                                                       admin/notifications#new
         edit_admin_notification GET    /admin/notifications/:id/edit(.:format)                                                  admin/notifications#edit
              admin_notification GET    /admin/notifications/:id(.:format)                                                       admin/notifications#show
                                 PATCH  /admin/notifications/:id(.:format)                                                       admin/notifications#update
                                 PUT    /admin/notifications/:id(.:format)                                                       admin/notifications#update
                                 DELETE /admin/notifications/:id(.:format)                                                       admin/notifications#destroy
           admin_user_categories GET    /admin/user_categories(.:format)                                                         admin/user_categories#index
                                 POST   /admin/user_categories(.:format)                                                         admin/user_categories#create
         new_admin_user_category GET    /admin/user_categories/new(.:format)                                                     admin/user_categories#new
        edit_admin_user_category GET    /admin/user_categories/:id/edit(.:format)                                                admin/user_categories#edit
             admin_user_category GET    /admin/user_categories/:id(.:format)                                                     admin/user_categories#show
                                 PATCH  /admin/user_categories/:id(.:format)                                                     admin/user_categories#update
                                 PUT    /admin/user_categories/:id(.:format)                                                     admin/user_categories#update
                                 DELETE /admin/user_categories/:id(.:format)                                                     admin/user_categories#destroy
             admin_user_monitors GET    /admin/user_monitors(.:format)                                                           admin/user_monitors#index
                                 POST   /admin/user_monitors(.:format)                                                           admin/user_monitors#create
          new_admin_user_monitor GET    /admin/user_monitors/new(.:format)                                                       admin/user_monitors#new
         edit_admin_user_monitor GET    /admin/user_monitors/:id/edit(.:format)                                                  admin/user_monitors#edit
              admin_user_monitor GET    /admin/user_monitors/:id(.:format)                                                       admin/user_monitors#show
                                 PATCH  /admin/user_monitors/:id(.:format)                                                       admin/user_monitors#update
                                 PUT    /admin/user_monitors/:id(.:format)                                                       admin/user_monitors#update
                                 DELETE /admin/user_monitors/:id(.:format)                                                       admin/user_monitors#destroy
                      admin_root GET    /admin(.:format)                                                                         admin/users#index
api_v1_refresh_app_monitor_index POST   /api/v1/refresh_app_monitor(.:format)                                                    api/v1/refresh_app_monitor#create
                     sidekiq_web        /sidekiq                                                                                 Sidekiq::Web
     user_category_user_monitors GET    /user_categories/:user_category_id/user_monitors(.:format)                               user_monitors#index
                                 POST   /user_categories/:user_category_id/user_monitors(.:format)                               user_monitors#create
  new_user_category_user_monitor GET    /user_categories/:user_category_id/user_monitors/new(.:format)                           user_monitors#new
               edit_user_monitor GET    /user_monitors/:id/edit(.:format)                                                        user_monitors#edit
                    user_monitor GET    /user_monitors/:id(.:format)                                                             user_monitors#show
                                 PATCH  /user_monitors/:id(.:format)                                                             user_monitors#update
                                 PUT    /user_monitors/:id(.:format)                                                             user_monitors#update
                                 DELETE /user_monitors/:id(.:format)                                                             user_monitors#destroy
                 user_categories GET    /user_categories(.:format)                                                               user_categories#index
                                 POST   /user_categories(.:format)                                                               user_categories#create
               new_user_category GET    /user_categories/new(.:format)                                                           user_categories#new
              edit_user_category GET    /user_categories/:id/edit(.:format)                                                      user_categories#edit
                   user_category GET    /user_categories/:id(.:format)                                                           user_categories#show
                                 PATCH  /user_categories/:id(.:format)                                                           user_categories#update
                                 PUT    /user_categories/:id(.:format)                                                           user_categories#update
                                 DELETE /user_categories/:id(.:format)                                                           user_categories#destroy
              rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
       rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
              rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
       update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
            rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
`
export default RoutesDump
