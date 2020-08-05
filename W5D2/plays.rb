require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
    include Singleton

    def initialize #same thing as plays_db = SQLite3::Database.new('./plays.db')
        super('plays.db')
        self.type_translation = true
        self.results_as_hash = true #data will come back as a hash instead of an array
    end
end

class Play

    attr_accessor :title, :year, :playwright_id

    def self.find_by_title(title)
        # data = PlayDBConnection.instance.execute('SELECT * FROM plays WHERE plays.title = title')
        # data.map { |datum| Play.new(datum) }
        play = PlayDBConnection.instance.execute(<<-SQL, title)
            SELECT
                *
            FROM
                plays
            WHERE
                title = ?
        SQL
        return nil unless play.length > 0

        Play.new(play.first)
    end

    # def self.find_by_playwright(name)
    #     data = PlayDBConnection.instance.execute('SELECT * FROM plays JOIN playwrights ON plays.playwright_id = playwrights.id WHERE playwrights.name = name')
    #     data.map { |datum| Play.new(datum) }
    # end

    def self.find_by_playwright(name)
        playwright = Playwright.find_by_name(name)
        raise "#{name} not found in DB" unless playwright

        plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
            SELECT
                *
            FROM
                plays
            WHERE
                playwright_id = ?
        SQL

        plays.map { |play| Play.new(play) }
    end

    def self.all
        data = PlayDBConnection.instance.execute('SELECT * FROM plays')
        data.map { |datum| Play.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @year = options['year']
        @playwright_id = options['playwright_id']
    end

    def create
        raise '#{self} already in database' if @id
        PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
            INSERT INTO 
                plays(title, year, playwright_id)
            VALUES
                (?, ?, ?) 
        SQL
        @id = PlayDBConnection.instance.last_insert_row_id
    end

    def update
        raise '#{self} not in database' unless @id
        PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
            UPDATE
                plays
            SET
                title = ?, year = ?, playwright_id = ?
            WHERE
                id = ?
        SQL
    end

end

class Playwright 

    attr_accessor :id, :name, :birth_year

    def self.all
        data = PlayDBConnection.instance.execute('SELECT * FROM playwrights')
        data.map { |datum| Playwright.new(datum) }
    end

    # def Playwright::find_by_name(name)
    #     data = PlayDBConnection.instance.execute('SELECT * FROM playwrights WHERE playwrights.name = name')
    #     data.map { |datum| Playwright.new(datum) }
    # end

    def self.find_by_name(name)
        person = PlayDBConnection.instance.execute(<<-SQL, name)
            SELECT
                *
            FROM
                playwrights
            WHERE
                name = ?
        SQL
        return nil unless person.length > 0 

        Playwright.new(person.first)
    end

    def initialize(options)
        @id = options['id']
        @name = options['name']
        @birth_year = options['birth_year']
    end

    def create
        raise '#{self} already in database' if @id
        PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
            INSERT INTO 
                plays(name, birth_year)
            VALUES
                (?, ?) 
        SQL
        @id = PlayDBConnection.instance.last_insert_row_id
    end

    def update
        raise '#{self} not in database' unless @id
        PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
            UPDATE
                plays
            SET
                name = ?, birth_year = ?
            WHERE
                id = ?
        SQL
    end

    # def get_plays
    #     data = PlayDBConnection.instance.execute('SELECT * FROM plays JOIN playwrights ON plays.playwright_id = playwrights.id WHERE playwrights.name = self.name')
    #     data.map { |datum| Play.new(datum) }
    # end

    def get_plays
        raise "#{self} not in database" unless self.id
        plays = PlayDBConnection.instance.execute(<<-SQL, self.id)
            SELECT
                *
            FROM
                plays
            WHERE
                playwright_id = ?
        SQL
        plays.map { |play| Play.new(play) }
  end
end