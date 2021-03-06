# Copyright (C) 2009 Pascal Rettig.

require 'fileutils'
require 'digest/sha1'
require 'csv'

class MemberImportWorker <  Workling::Base #:nodoc:all
  
  # Args: file_path
  # 
  def do_work(args)
  
    results = { }
  
    dmn = Domain.find(args[:domain_id])
    DomainModel.activate_domain(dmn.get_info,'migrator',false)
    
    results[:completed] = false
    
    file = DomainFile.find_by_id args[:csv_file]
    filename = file.filename

    count = -1
    CSV.open(filename,"r",args[:deliminator]).each do |row|
      count += 1 if !row.join.blank?
    end
    count = 1 if count < 1
    results[:entries] = count
    
    
    results[:initialized] = true
    results[:imported] = 0
    EndUser.import_csv(filename,args[:data],:import => true, :options => args[:options],:deliminator => args[:deliminator]) do |imported,errors|
      results[:imported] += imported
      Workling.return.set(args[:uid],results)
    end
    
    results[:completed] = true
    Workling.return.set(args[:uid],results)
  end
end
