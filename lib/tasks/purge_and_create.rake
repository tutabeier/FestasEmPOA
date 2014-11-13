# lib/tasks/purge_and_create.rb
namespace :purge_and_create do
  desc "Zera banco de dados"
  task :purge => :environment do
    puts "Iniciando purge BD: #{Time.now}."
    Beco.delete_all
    Cdl.delete_all
    Cucko.delete_all
    Opiniao.delete_all
    Silencio.delete_all
    puts "Finalizano purge BD: #{Time.now}."
  end

  desc "Popula banco de dados"
  task :create => :environment do
    puts "Iniciando create BD: #{Time.now}."
    Beco.new.parties
    Cdl.new.parties
    Cucko.new.parties
    Opiniao.new.parties
    Silencio.new.parties
    puts "Finalizando create BD: #{Time.now}."
  end
end
