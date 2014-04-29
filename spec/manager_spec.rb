require 'stashboardmanager'

describe Stashboardmanager::Manager do
  #Setup the remote instance ready for the tests
  manager = Stashboardmanager::Manager.new("https://stashmanagertest.appspot.com", "1/3x3oY6MRqACaMmuzr0pr76_3J9zkB3sJX_rIMCFU-cU", "p2K71wl3ekDBNF88UcAnFfUi")

  ids = manager.service_ids

  ids.each do |id|
    manager.service_update(id, "up", "Resetting #{id} for testing purposes")
  end

  id = ids[0]

  it "Has reset all" do
    manager.service_status(id).should eql("up")
  end

  it "Can update status" do
    manager.service_update(id, "down", "test that we can set #{id} to 'down'")
    manager.service_status(id).should eql("down")
  end

  it "Can mass-asign" do
    ids.each do |id|
      manager.service_update(id, "warning", "Warning on #{id} for testing purposes")
      manager.service_status(id).should eql("warning")
    end
  end
end