require 'mechanize'

class Chinanet
  ##
  # config
  # username: username
  # password: password
  # pro: current province
  # province: account province
  def initialize(config = {})
    @agent = Mechanize.new
    @agent.user_agent_alias = 'iPad'

    @config = Hash[config.map { |k, v| [k.to_sym, v] }]
  end

  def login
    # Get cookies
    @agent.get('https://portal.wifi.189.cn')

    # Fill login form
    front_page = @agent.get('https://portal.wifi.189.cn/v50/index_1.jsp')
    login_form = front_page.forms[2]
    login_form.pro = @config[:pro]
    login_form.userName = @config[:username]
    login_form.password = @config[:password]
    login_form.provinceCode = @config[:province]
    login_form.submit
  end

  def logout
    status_page = @agent.get('https://portal.wifi.189.cn/v50/success_phbb.jsp?accountType=common')
    status_page.form('form1').submit
  end

  def keep_alive
    @agent.get('https://portal.wifi.189.cn/v50/images/8.png')
  end
end
