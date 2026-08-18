{% extends '_layout.swig' %}
{% import '_macro/post-collapse.swig' as post_template with context %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}{{ __('title.archive') }} | {{ title }}{% endblock %}

{% block class %}archive{% endblock %}

{% block content %}

  {#####################}
  {### ARCHIVE BLOCK ###}
  {#####################}
  <div class="post-block">
    <div class="posts-collapse">
      <div class="collection-title">
        {%- set posts_length = site.posts.length %}
        {%- if posts_length > 210 %}
          {%- set cheers = 'excellent' %}
        {% elif posts_length > 130 %}
          {%- set cheers = 'great' %}
        {% elif posts_length > 80 %}
          {%- set cheers = 'good' %}
        {% elif posts_length > 50 %}
          {%- set cheers = 'nice' %}
        {% elif posts_length > 30 %}
          {%- set cheers = 'ok' %}
        {% else %}
          {%- set cheers = 'um' %}
        {%- endif %}
        <span class="collection-header">{{ __('cheers.' + cheers) }}! {{ _p('counter.archive_posts', site.posts.length) }} {{ __('keep_on') }}</span>
      </div>

      {{ post_template.render(page.posts) }}

    </div>
  </div>
  {#########################}
  {### END ARCHIVE BLOCK ###}
  {#########################}

  {% include '_partials/pagination.swig' %}

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}


<%- partial('_partial/head') %>

<%- page.title %>

  <ul class="archive-list">
    <% for (var post of page.posts) { %>
      <li >
        <a rel="nofollow" href="<%- post.permalink %>"> <%- post.title %> </a >
        <span > <%- post.date.format('YYYY-MM-DD') %> </span >
      </li>
    <%}%>
  </ul>


<%- partial('_partial/footer') %>