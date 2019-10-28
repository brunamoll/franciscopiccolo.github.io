---
layout: archive
permalink: /machine-learning/
title: "Articles teste 3"
pagination:
  enabled: true
date: 2016-08-26
---

{% include base_path %}
{% capture written_year %}'None'{% endcapture %}
{% for post in site.posts %}
  {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
  {% if year != written_year %}
    <h2 id="{{ year | slugify }}" class="archive__subtitle"><a href="#{{ year | slugify }}">#{{ year }}</a></h2>
    {% capture written_year %}{{ year }}{% endcapture %}
  {% endif %}
  {% include archive-single.html %}
{% endfor %}
