module WordWalker
  module Report
    def results(best_of = 3)
      if @grids.count == 0
        puts "No grids to report on.  Try running #build_grids(no. of passes) first."
      else
        @failures = @grids.select { |g| g.score == -1 }
        grids = @grids - @failures

        clear_screen

        puts "\n##### RESULTS #####\n\n"

        if grids.count == 0
          puts "No successful grids were built.  Try increasing the number of passes or shortening the passage."
        else
          puts "\n##### TOP #{best_of > 1 ? "#{best_of} GRIDS" : "GRID"} #####\n\n"
          grids.max_by(best_of) do |grid|
            grid.score
          end.each do |grid|
            grid.print_field
            puts "Score: #{grid.score.round(2)}\n\n"
          end

          puts "\n##### WORST QUALIFYING GRID #####\n\n"
          loser = grids.min_by do |grid|
            grid.score
          end

          loser.print_field
          puts "Score: #{loser.score.round(2)}\n\n"
        end

        puts "\n##### STATISTICS #####\n\n"
        puts "Failure Rate: #{failure_rate}%"

        unless failure_rate == 0.0
          puts "Average completion rate of failed grids: #{average_completion_of_failures.round(2)}%"
        end

        if @failures.count == @passes
          puts "The most successful failure reached #{best_failure.percent_complete.round(2)}% completion."
        end
      end
    end

    def average_completion_of_failures
      @failures.map do |failure|
        failure.percent_complete
      end.reduce(:+).to_f / @failures.count
    end

    def best_failure
      @best_failure ||= @failures.max_by { |f| f.percent_complete }
    end

    def failure_rate
      @failure_rate ||= unless @failures.count == 0
        (@failures.count.to_f / @grids.count.to_f * 100).round(2)
      else
        0.0
      end
    end

    def print_standby_message (passes, current_pass)
      clear_screen

      puts "################ BUILD IN PROGRESS ################\n\n"
      puts "Attempting to build your grids.  Please stand by..."
      puts "Completed: #{current_pass} / #{passes}\n\n"
      puts "###################################################"
    end

    def clear_screen
      system "clear" or system "cls"
    end

    extend self
  end
end
