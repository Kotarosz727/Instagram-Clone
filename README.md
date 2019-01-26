# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
<% provide(:title, "投稿") %>

<div class="d-flex flex-column align-items-center mt-3">
  <div class="col-xl-7 col-lg-8 col-md-10 col-sm-11 post-card">
    <div class="card">
      <div class="card-header">
        投稿画面
      </div>
      
  <div class="card-body">
   <%= form_for(@micropost) do |f| %>
   <%= render 'shared/error_messages', object: f.object %>
    <div class="form-group row mt-2">
    <%= f.text_field :content,class: "form-control border-0", placeholder: "キャプションを書く" %>
     </div>
    <div class="col pl-0">
     <%= f.file_field :picture, accept: 'image/jpeg,image/gif,image/png' %>
    </div> 
    </div>
  <%= f.submit "投稿する", class: "btn btn-primary" %>
  <span class="picture">
   
  </span>
<% end %>

<script type="text/javascript">
  $('#micropost_picture').bind('change', function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert('Maximum file size is 5MB. Please choose a smaller file.');
    }
  });
</script> 