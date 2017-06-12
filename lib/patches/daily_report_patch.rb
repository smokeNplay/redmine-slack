module RedmineSlack
  module DailyReportPatch # :nodoc:
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable
        after_save :add_hook
      end
    end

    module InstanceMethods # :nodoc:
      include Redmine::Hook::Helper

      def add_hook
        call_hook(:model_daily_report_after_save, daily_report: self)
      end
    end
  end
end

DailyReport.send(:include, RedmineSlack::DailyReportPatch)
