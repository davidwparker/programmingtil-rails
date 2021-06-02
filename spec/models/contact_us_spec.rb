# == Schema Information
#
# Table name: contact_us
#
#  id         :bigint           not null, primary key
#  name       :string
#  email      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe ContactUs, type: :model do
  include ActiveJob::TestHelper

  context 'Validations' do
    it 'requires a body' do
      contact = create_contact_us
      expect(contact.valid?).to eq true
      contact.body = nil
      expect(contact.valid?).to eq false
    end

    it 'requires a name' do
      contact = create_contact_us
      expect(contact.valid?).to eq true
      contact.name = nil
      expect(contact.valid?).to eq false
    end

    it 'requires a email' do
      contact = create_contact_us
      expect(contact.valid?).to eq true
      contact.email = nil
      expect(contact.valid?).to eq false
    end

    it 'disallows certain spam words in body' do
      contact = create_contact_us
      expect(contact.valid?).to eq true
      contact.body = 'cryptocurrency'
      expect(contact.valid?).to eq false
    end

    it 'disallows certain spam words in name' do
      contact = create_contact_us
      expect(contact.valid?).to eq true
      contact.name = 'cryptocurrency'
      expect(contact.valid?).to eq false
    end
  end

  context "Hooks" do
    it 'downcases the email' do
      contact = create_contact_us({ email: 'Email@OK.com' })
      expect(contact.email).to eq 'email@ok.com'
    end

    it 'queues up the admin email' do
      contact = create_contact_us
      expect(enqueued_jobs.size).to eq 1
      expect(enqueued_jobs.first['arguments'].first).to eq 'Emails::ContactUsMailer'
      expect(enqueued_jobs.first['arguments'].second).to eq 'contact'
    end
  end
end
