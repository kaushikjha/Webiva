# Copyright (C) 2009 Pascal Rettig.
require 'fastercsv'

class EmarketingController < CmsController # :nodoc: all
  include ActionView::Helpers::DateHelper

  layout 'manage'

  cms_admin_paths 'marketing',
    'Marketing' => { :action => 'index' }
  
  permit ['editor_visitors','editor_members','editor_mailing'], :only => :index
  permit 'editor_visitors', :except => :index

  def index
    cms_page_path [],'Marketing'
    
    
    @subpages = [
       [ "Visitor Statistics", :editor_visitors, "emarketing_statistics.gif", { :action => 'visitors' }, 
          "View and Track Visitors to your site" ],
       [ "Real Time Statistics", :editor_visitors, "emarketing_statistics.gif", { :action => 'stats' }, 
          "View Real Time Visits to your site" ]
    ]

    get_handler_info(:chart, :traffic).each do |handler|
      @subpages << [handler[:name], :editor_visitors, 'emarketing_statistics.gif', handler[:url], handler[:description] || handler[:name]]
    end

    @subpages << ['Experiments', :editor_visitors, 'emarketing_statistics.gif', {:controller => '/experiment', :action => 'index'}, 'View Experiments Results']
  end
  
 include ActiveTable::Controller   
  active_table :visitor_table,
                DomainLogVisitor,
                [ ActiveTable::StaticHeader.new('user', :label => 'Who'),
                  ActiveTable::DateRangeHeader.new('created_at', :label => 'When'),
                  ActiveTable::StaticHeader.new('page_count', :label => 'Pages'),
                  ActiveTable::StaticHeader.new('time_on_site', :label => 'Stayed')
                ]
  
  def visitor_table_output(opts)
     option_hash = 
        { :order => 'updated_at DESC'
        }
     @active_table_output = visitor_table_generate opts, option_hash
  end  
  
  def visitor_update
    visitor_table_output(params)
    
    render :partial => 'visitor_table'
  end
  
  def visitors
    cms_page_path ['Marketing'], 'Visitors'
    visitor_table_output params
    
    google = Configuration.google_analytics
    @options = DefaultsHashObject.new({
                      :google_analytics => google[:enabled] ? 'enabled' : 'disabled',
                      :analytics_code => google[:code],
                })
  end
  
  def options_update
    options = params[:options]
    
    google = Configuration.retrieve('google_analytics',{})
    google.options[:enabled] = options[:google_analytics] == 'enabled' ? 'enabled' : 'disabled'
    google.options[:code] = options[:analytics_code]
    google.save
    
    render :nothing => true
  end
  
  def visitor_detail
    visitor_id = params[:path][0]
    
    @entry = DomainLogVisitor.find_by_id(visitor_id)
    if @entry && @entry.end_user
      @user = @entry.end_user
    end
    
    @sessions = @entry.session_details
    
    render :partial => 'visitor_detail'
  end
  
  def site_statistics
    conditions = '1'
  
    @stats = DefaultsHashObject.new(
      { 
        :unique_ips => DomainLogSession.count('ip_address',:distinct => true,:conditions => conditions),
        :unique_sessions => DomainLogEntry.count('domain_log_session_id',:distinct => true,:conditions => conditions),
        :registered_users => DomainLogEntry.count('user_id',:distinct => true,:conditions => conditions + " AND user_id IS NOT NULL"),
        :anonymous_users => DomainLogSession.count('ip_address',:distinct => true,:conditions => conditions + " AND end_user_id IS NULL"),
        :total_hits => DomainLogEntry.count(:conditions => conditions)
      }
    )
    
    
    @page_stats = DomainLogEntry.find(:all,
                :group => 'node_path',
                :select => 'node_path, COUNT(*) as views',
                :order => 'views DESC')
                
                
    render :partial => 'site_statistics'
  end

  def stats
    cms_page_path ['Marketing'], 'Real Time Statistics'
    require_js 'emarketing.js'
  end

  def charts
    @stat_type = params[:path][0]
    @handler, @format = params[:path][1..-1].join('/').split('.')
    if @handler =~ /\/(\d+)$/
      @target_id = $1.to_i
      @handler.sub!("/#{@target_id}", '')
    end
    @type_id = params[:type_id] ? params[:type_id].to_i : nil
    @type_id = nil if @type_id == 0

    @chart_info = get_handler_info(:chart, @stat_type, @handler)

    raise 'No chart found' unless @chart_info

    @when = params[:when] || 'today'
    @all_fields = params[:all]

    @from = Time.now.at_midnight
    @duration = 1.day
    @interval = 1

    @when_options = [['Today', 'today'], ['Yesterday', 'yesterday'], ['This Week', 'week'], ['Last Week', 'last_week'], ['This Month', 'month'], ['Last Month', 'last_month']]

    case @when
    when 'today'
      @from = Time.now.at_midnight
      @duration = 1.day
    when 'yesterday'
      @from = Time.now.at_midnight.yesterday
      @duration = 1.day
    when 'week'
      @from = Time.now.at_beginning_of_week
      @duration = 1.week
    when 'last_week'
      @from = Time.now.at_beginning_of_week - 1.week
      @duration = 1.week
    when 'month'
      @from = Time.now.at_beginning_of_month
      @duration = 1.month
    when 'last_month'
      @from = Time.now.at_beginning_of_month - 1.month
      @duration = 1.month
    end

    groups = @chart_info[:class].send(@stat_type, @from, @duration, @interval, :target_id => @target_id, :type_id => @type_id)
    @group = groups[0]
    @stats = @target_id ? @group.target_stats : @group.domain_log_stats
    @title = @chart_info[:title] || :title

    if @format == 'json'
      data = {:from => @from, :duration => @duration, :stat_type => @stat_type, :when => @when, :target_id => @target_id, :type_id => @type_id}
      if @all_fields
        data[:columns] = ['Visitors', 'Hits', 'Subscribers', 'Leads', 'Conversions']
        data[:data] = @stats.collect { |stat| [stat.visits, stat.hits, stat.subscribers, stat.leads, stat.conversions] }
      else
        data[:columns] = ['Visitors', 'Hits']
        data[:data] = @stats.collect { |stat| [stat.visits, stat.hits] }
      end
      return render :json => data
    elsif @format == 'csv'
      report = StringIO.new
      csv_data = FasterCSV.generate do |writter|
        writter << ['Title', 'Visitors', 'Hits', 'Subscribers', 'Leads', 'Conversions']
        @stats.each do |stat|
          writter << [stat.target.send(@title), stat.visits, stat.hits, stat.subscribers, stat.leads, stat.conversions]
        end
      end
      return send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=stats.csv"
    end

    if @chart_info[:type_options]
      @type_options = @chart_info[:type_options].is_a?(Symbol) ? @chart_info[:class].send(@chart_info[:type_options]) : @chart_info[:type_options]
    end

    cms_page_path ['Marketing'], @chart_info[:name]

    require_js 'protovis/protovis-r3.2.js'
    require_js 'tipsy/jquery.tipsy.js'
    require_js 'protovis/tipsy.js'
    require_css 'tipsy/tipsy.css'
    require_js 'charts.js'
  end

  def real_time_stats_request
    now = Time.now
    from = params[:from] ? Time.at(params[:from].to_i) : nil

    conditions = from ? ['occurred_at between ? and ?', from, now] : ['occurred_at between ? and ?', 1.hour.ago, now]
    order = from ? 'occurred_at' : 'occurred_at DESC'
    @entries = DomainLogEntry.find(:all, :limit => 50, :conditions => conditions, :order => order, :include => [:domain_log_session, :user, :end_user_action])
    @remaining = from ? DomainLogEntry.count(:all, :conditions => conditions) : 0
    @remaining -= 50
    @remaining = 0 if @remaining < 0

    last_occurred_at = nil
    @entries.map! do |entry|
      last_occurred_at = entry.occurred_at.to_i

      { :id => entry.domain_log_session.domain_log_visitor_id || '#',
	:occurred => entry.occurred_at.to_i,
	:occurred_at => entry.occurred_at.strftime('%I:%M:%S %p'),
	:url => entry.url,
	:ip => entry.domain_log_session.ip_address,
	:user => entry.user? ? entry.username : nil,
	:status => entry.http_status,
	:action => entry.action
      }
    end

    @entries.reverse! if from.nil?

    @entries << {:occurred_at => nil, :remaining => @remaining} if @remaining > 0
    render :json => [now.to_i, @entries]
  end

  def real_time_charts_request
    range = (params[:range] || 5).to_i
    intervals = (params[:intervals] || 10).to_i
    update_only = (params[:update] || 0).to_i == 1
    site_node_id = params[:site_node_id]

    now = Time.now
    now = now.to_i - (now.to_i % range.minutes)
    to = now
    from = now - (range*intervals).minutes

    uniques = []
    hits = []
    labels = []
    groups = []
    if site_node_id
      site_node = SiteNode.find_by_id site_node_id
      groups = site_node.traffic(Time.at(from), range.minutes, intervals) if site_node
    else
      groups = DomainLogEntry.traffic Time.at(from), range.minutes, intervals
    end

    groups.sort { |a,b| b.started_at <=> a.started_at }.each do |group|
      stat = group.domain_log_stats[0]
      if stat
        uniques << stat.visits
        hits << stat.hits
      else
        uniques << 0
        hits << 0
      end
      labels << group.ended_at.strftime('%I:%M')
      break if update_only
    end

    from = to - (range*intervals).minutes

    format = '%b %e, %Y %I:%M%P'
    data = { :range => range, :from => Time.at(from).strftime(format), :to => Time.at(to).strftime(format), :uniques => uniques, :hits => hits, :labels => labels }
    return render :json => data
  end
end
