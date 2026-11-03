---
show: true
width: 12
date: 2026-08-09 00:01:00 +0800
group: Cats
class: ""
images:
- assets/images/cats/carousel/img-9694.jpg
- assets/images/cats/carousel/dsc-0061.jpg
- assets/images/cats/carousel/img-2839.jpg
- assets/images/cats/carousel/img-7429.jpg
---

<div class="row mx-n2">
    {% for image in page.images %}
    <div class="col-lg-3 col-sm-6 p-2">
        <img data-src="{{ image | relative_url }}" class="lazy w-100 rounded-xl shadow-sm" src="{{ '/assets/images/empty_300x200.png' | relative_url }}" alt="Beibei, a British Shorthair cat">
    </div>
    {% endfor %}
</div>
