# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    class Cli < Thor::Group
      def self.banner
        'agharta [task or recipe]'
      end

      include Actions

      def self.desc
        tasks = "Tasks:\n"
        Tasks.mappings.each do |task_name, klass|
          tasks << "  #{klass.banner.ljust(36)} # #{klass.desc}\n"
        end
        tasks
      end

      def setup
        help if ARGV.empty?
        @task = Tasks.mappings[ARGV.first.to_s.downcase.to_sym]
        if @task
          ARGV.delete_at(0)
        else
          @task = Agharta::Tasks::Execute
        end
      end

      def boot
        @task.start(ARGV)
      end
    end
  end
end
