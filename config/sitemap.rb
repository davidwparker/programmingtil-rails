# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "localhost:5000"
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  add "/about",
    changefreq: 'yearly',
    lastmod: '2021-05-13T09:19:54-06:00',
    priority: 0.4
  Post.published.order(id: :desc).each do |post|
    add "/posts/#{post.slug}",
      changefreq: 'weekly',
      lastmod: post.published_at,
      priority: 0.6
  end
end
