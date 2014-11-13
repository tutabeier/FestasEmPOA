# lib/tasks/purge_and_create.rb
namespace :purge_and_create do
  desc "Zera banco de dados"
  task :purge => :environment do
    Beco.delete_all
    Cdl.delete_all
    Cucko.delete_all
    Opiniao.delete_all
    Silencio.delete_all
    puts "#{Time.now} - Success!"
  end

  desc "Popula banco de dados"
  task :create => :environment do
    Beco.new.parties
    Cdl.new.parties
    Cucko.new.parties
    Opiniao.new.parties
    Silencio.new.parties
    puts "#{Time.now} - Success!"
  end
end
