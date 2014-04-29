require "stashboard"
require "stashboardmanager/version"

module Stashboardmanager
  # Main class for interacting with StashboardManager.
  class Manager
    @stashboard = nil

    # Create a new StashboardManager instance.
    def initialize(address, token, secret)
      @stashboard = Stashboard::Stashboard.new(address, token, secret)
    end

    # Check to see if a service is already set as 'status'. If not, update it.
    #
    # @param [String] service The service you are attempting to set
    # @param [String] status The status you are attempting to set
    # @param [String] message The message you wish to attach to this update
    def service_update(service, status, message)
      if service_updatable(service, status)
        self.generate_stashboard_event(service, status, message)
      end
    end

    # Get all services attached to this stashboard.
    #
    # @return [Hash] services A hash containing an array of service detail hashes, or an error message
    def services
      @stashboard.services
    end

    # Get an array of service ids. This is just for convenience/
    #
    # @return [Array] Services Array containing just the service ids
    def service_ids
      @stashboard.service_ids
    end

    # Get the current status of a service.
    #
    # @param [String] service The service you are attempting to set
    # @return [Hash] details A hash containing the details for this service
    def service_status(service)
      #Do we have a service for this set up
      services = self.service_ids
      exists = services.include? service

      status = false

      #Make sure we have some services and that this one exists
      if exists
        #Get the service's details
        s = @stashboard.service(service)

        #Grab the current event
        current_event = s["current-event"]

        #Make sure we have a current event
        if(!current_event.nil?)
          status = current_event["status"]["id"]
        end
      end

      status
    end

    # Is this service updatable?
    #
    # @param [String] service The name of the service you want to check
    # @param [String] status The status you are trying to update the service to
    # @return [Boolean] response Response containing a true if this service should be updated, a false if it shouldn't OR a nil if the service doesn't exist
    def service_updatable(service, status)
      #What is the current service status?
      serv_stat = self.service_status(service)

      if serv_stat == false       #If false then don't continue (the service does not exist on remote)
        return nil
      elsif serv_stat == status   #If match don't update
        return false
      else                        #No match - update
        return true
      end
    end

    # Create an event of a service. Events are the main way we
    # indicate problems or resolutions of issues.
    #
    # @param [String] service The service you want to update
    # @param [String] id The id of an already existing status (i.e. "up", "down", "warning" or "error")
    # @param [String] message The message we want our event to have attached
    # @return [Hash] event The event details
    def generate_stashboard_event(service, status, message)
      @stashboard.create_event(service, status, message)
    end
  end

end
