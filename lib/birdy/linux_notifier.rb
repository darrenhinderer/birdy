class LinuxNotifier

  DISPLAY_TIME_SECONDS = 5

  def initialize
    @notify = RBus.session_bus.get_object('org.freedesktop.Notifications', 
      '/org/freedesktop/Notifications')
  end

  def show(image_path, name, message)
    app_name = 'birdy'
    replaces_id = 0
    app_icon = image_path
    summary = name
    body = wrap_links(message)
    actions = []
    hints = {}
    expire_timeout = DISPLAY_TIME_SECONDS * 1000

    @notify.Notify(app_name, replaces_id, app_icon, summary, body, actions, 
                   hints, expire_timeout)
    sleep DISPLAY_TIME_SECONDS
  end

  def wrap_links(text)
    text.gsub(%r{ ( https?:// | www\. ) [^\s<]+ }x) do
      href = $&
      "<a href='" + href + "'>" + href + "</a>"
    end
  end

end
