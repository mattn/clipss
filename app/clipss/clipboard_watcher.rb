module Clipss
  class ClipboardWatcher
    @interval = 1
    class << self
      attr_accessor :interval
      def run
        thread_loop
      end

      def thread_loop
        th = Thread.start do
          loop do
            begin
              loop_process
            end
            sleep @interval  unless @interval.nil?
          end
        end
      end

      def loop_process
        cdata = Clipss::Var::Clipboard.get
        
        if Clipss::Var::History.get != cdata
          Cmd::push_cwatcher cdata              
        end

      end
      
    end
  end
end
