require 'identity/importer/tasks/civicrm/mailings'
require 'identity/importer/tasks/civicrm/members'
require 'identity/importer/tasks/civicrm/mailing_members'
require 'identity/importer/tasks/civicrm/opens'
require 'identity/importer/tasks/civicrm/clicks'

require 'identity/importer/tasks/actionkit/mailings'
require 'identity/importer/tasks/actionkit/members'
require 'identity/importer/tasks/actionkit/mailing_members'
require 'identity/importer/tasks/actionkit/opens'
require 'identity/importer/tasks/actionkit/clicks'

module Identity
  module Importer
    module Tasks

      def self.run
        Identity::Importer::Tasks::CiviCRM::Mailings.run
        Identity::Importer::Tasks::CiviCRM::Members.run
        # Identity::Importer::Tasks::CiviCRM::MailingMembers.run
        # Identity::Importer::Tasks::CiviCRM::Opens.run
        # Identity::Importer::Tasks::CiviCRM::Clicks.run
      end

    end
  end
end
