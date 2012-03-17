$('#news_<%= @news.id%> .main_image').attr('src', '<%= @picture.image.url(:normal)%>');
$('#news_<%= @news.id%> .active').removeClass('active');
$('#mini_pic_<%= @picture.id%>').addClass('active');