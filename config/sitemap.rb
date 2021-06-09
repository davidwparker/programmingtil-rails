require 'aws-sdk-s3'

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://ptil-rails-staging-api.herokuapp.com"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.compress = false
SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  "programmingtil-rails-#{Rails.env}",
  aws_access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
  aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
  aws_region: 'us-west-1'
)

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
