module Talks
  Talks = {
    "Pryin open the black box 60 minutes" => 60, 
    "Migrating a huge production codebase from sinatra to Rails 45 minutes" => 45,
    "How does bundler work 30 minutes" => 30,
    "Sustainable Open Source 45 minutes" => 45,
    "How to program with Accessiblity in Mind 45 minutes" => 45,
    "Riding Rails for 10 years lightning talk" => 5,
    "Implementing a strong code review culture 60 minutes" => 60,
    "Scaling Rails for Black Friday 45 minutes" => 45,
    "Docker isn't just for deployment 30 minutes" => 30,
    "Callbacks in Rails 30 minutes" => 35,
    "Microservices, a bittersweet symphony 45 minutes" => 45,
    "Teaching github for poets 60 minutes" => 60,
    "Test Driving your Rails Infrastucture with Chef 60 minutes" => 60,
    "SVG charts and graphics with Ruby 45 minutes" => 45,
    "Interviewing like a unicorn How Great Teams Hire 30 minutes" => 30,
    "How to talk to humans a different approach to soft skills 30 minutes" => 30,
    "Getting a handle on Legacy Code 60 minutes" => 60,
    "Heroku A year in review 30 minutes" => 30,
    "Ansible An alternative to chef lightning talk" => 5,
    "Ruby on Rails on Minitest 30 minutes" => 30,
  }
end



class Track
  def initialize(name)
    @sessions = []
    @name = name
  end

  def add_sessions(talk)
    @sessions << talk
  end

  def showTracks
    track = "\nTrack #{@name} \n"
    @sessions.each do |session|
      track += "\n#{session}\n"
    end
    track
  end
  
end



class Session
  attr_reader :talks, :year, :month, :day, :availabe_minutes

  def initialize(talks)
    @talks = talks
    @year, @month, @day = 2020, 12, 10
    @available_minutes = nil
  end

  def morningSessions(track)
    @start_time = Time.local(@year, @month, @day, 9)
    @end_time = Time.local(@year, @month, @day, 12)
    trackSchedule(track)
  end

  def afternoonSessions(track)
    @start_time = Time.local(year, month, day, 13)
    @end_time = Time.local(year, month, day, 17)
    trackSchedule(track)
  end

  def trackSchedule(track)
    @availabe_minutes = (@end_time.to_i - @start_time.to_i) / 60
    addTrack(track)
  end

  def addTrack(track)
    @talks.each do |talk, time|
      if time <= @availabe_minutes
        track.add_sessions("#{@start_time.strftime("%I:%M %p")} #{talk} #{time}")
        @availabe_minutes -= time
        @start_time += time * 60
        @talks.delete(talk)
      end
    end
  end



  def remainingTalks
    puts "\nRemaining Talks:\n"
    if !@talks.keys.length.zero?
      @talks.each do|talk, time|
        puts "\n#{@start_time.strftime("%I:%M %p")} #{talk} #{time}\n"
      end
    else
      puts "\nThere are no talks left!!\n"
    end
  end

end



class Conference
  def initialize(session)
    @session = session
    @tracks = []
  end

  def schedule
    createTrack("1")
    createTrack("2")
    displayAllTracks
    displayRemainingTracks
  end

  def createTrack(name)
    track = Track.new(name)
    @session.morningSessions(track)
    @session.afternoonSessions(track)
    @tracks << track
  end

  def displayAllTracks
    @tracks.each do|track|
      puts track.showTracks
    end
  end

  def displayRemainingTracks
    @session.remainingTalks
  end
end


session = Session.new(Talks::Talks)
Conference.new(session).schedule