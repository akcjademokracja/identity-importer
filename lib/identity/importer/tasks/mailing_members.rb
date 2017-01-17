require 'activerecord-import'

module Identity
  module Importer
    module Tasks
      class MailingMembers

        def self.run
          logger = Identity::Importer.logger
          unsynced_mailings = Mailing.where(recipients_synced: false)

          unsynced_mailings.each do |mailing|
            mailing_members = Identity::Importer.connection.run_query(sql(mailing.external_id))

            ActiveRecord::Base.transaction do
              member_mailings = []
              mailing_members.each do |mailing_member|
                member = Member.find_by(email: mailing_member['email'])
                member_id = member.try(:id) || 1

                member_mailing = MemberMailing.new
                member_mailing.attributes = {
                  'mailing_id' => mailing.id,
                  'member_id' => member_id,
                  'external_id' => mailing_member['id']
                }

                if member_mailing.new_record?
                  member_mailings << member_mailing
                  logger.debug "Importing MemberMailing with id #{member_mailing.id}"
                elsif member_mailing.changed?
                  member_mailing.save!
                  logger.debug "Updating MemberMailing with id #{member_mailing.id}"
                end
              end
              MemberMailing.import member_mailings

              mailing.recipients_synced = true
              mailing.save!
            end
          end

        end

      end
    end
  end
end
