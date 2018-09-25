module DialogsHelper
  def self.alert_role(timeout)
    return 'alert-danger' if timeout.negative?
    return 'alert-warning' if timeout > 5
    'alert'
  end
end
