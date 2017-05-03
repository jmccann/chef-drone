default['gogs']['install_dir'] = '/opt'
default['gogs']['version'] = '0.9.113'

default['gogs']['config']['global']['APP_NAME'] = 'Gogs: Go Git Service'
default['gogs']['config']['global']['RUN_USER'] = 'git'
default['gogs']['config']['global']['RUN_MODE'] = 'prod'

default['gogs']['config']['repository']['ROOT'] = '/ops/gogs/repos'
default['gogs']['config']['repository']['SCRIPT_TYPE'] = 'bash'

default['gogs']['config']['server']['PROTOCOL'] = 'http'
default['gogs']['config']['server']['DOMAIN'] = 'localhost'
default['gogs']['config']['server']['ROOT_URL'] = '%(PROTOCOL)s://%(DOMAIN)s:%(HTTP_PORT)s/'
default['gogs']['config']['server']['HTTP_ADDR'] = '0.0.0.0'
default['gogs']['config']['server']['HTTP_PORT'] = 8080
default['gogs']['config']['server']['DISABLE_SSH'] = false
default['gogs']['config']['server']['SSH_PORT'] = 22
default['gogs']['config']['server']['OFFLINE_MODE'] = false
default['gogs']['config']['server']['DISABLE_ROUTER_LOG'] = false
default['gogs']['config']['server']['CERT_FILE'] = 'custom/https/cert.pem'
default['gogs']['config']['server']['KEY_FILE'] = 'custom/https/key.pem'
default['gogs']['config']['server']['ENABLE_GZIP'] = false
default['gogs']['config']['server']['LANDING_PAGE'] = 'home'

default['gogs']['config']['database']['DB_TYPE'] = 'sqlite3'
default['gogs']['config']['database']['PATH'] = 'data/gogs.db'

# default['gogs']['config']['database']['DB_TYPE'] = 'mysql'
default['gogs']['config']['database']['HOST'] = '127.0.0.1:3306'
default['gogs']['config']['database']['NAME'] = 'gogs'
default['gogs']['config']['database']['USER'] = 'root'
default['gogs']['config']['database']['PASSWD'] = ''
default['gogs']['config']['database']['SSL_MODE'] = 'disable'

default['gogs']['config']['admin'] = {}

default['gogs']['config']['security']['INSTALL_LOCK'] = true
default['gogs']['config']['security']['SECRET_KEY'] = SecureRandom.urlsafe_base64(nil, true)
default['gogs']['config']['security']['LOGIN_REMEMBER_DAYS'] = 7
default['gogs']['config']['security']['COOKIE_USERNAME'] = 'gogs_awesome'
default['gogs']['config']['security']['COOKIE_REMEMBER_NAME'] = 'gogs_incredible'
default['gogs']['config']['security']['REVERSE_PROXY_AUTHENTICATION_USER'] = 'X-WEBAUTH-USER'

default['gogs']['config']['service']['ACTIVE_CODE_LIVE_MINUTES'] = 180
default['gogs']['config']['service']['RESET_PASSWD_CODE_LIVE_MINUTES'] = 180
default['gogs']['config']['service']['REGISTER_EMAIL_CONFIRM'] = false
default['gogs']['config']['service']['DISABLE_REGISTRATION'] = false
default['gogs']['config']['service']['REQUIRE_SIGNIN_VIEW'] = false
default['gogs']['config']['service']['ENABLE_CACHE_AVATAR'] = false
default['gogs']['config']['service']['ENABLE_NOTIFY_MAIL'] = false
default['gogs']['config']['service']['ENABLE_REVERSE_PROXY_AUTHENTICATION'] = false
default['gogs']['config']['service']['ENABLE_REVERSE_PROXY_AUTO_REGISTRATION'] = false
default['gogs']['config']['service']['DISABLE_MINIMUM_KEY_SIZE_CHECK'] = false

default['gogs']['config']['webhook']['TASK_INTERVAL'] = 1
default['gogs']['config']['webhook']['DELIVER_TIMEOUT'] = 5
default['gogs']['config']['webhook']['SKIP_TLS_VERIFY'] = false

default['gogs']['config']['mailer']['ENABLED'] = false
default['gogs']['config']['mailer']['SEND_BUFFER_LEN'] = 10
default['gogs']['config']['mailer']['SUBJECT'] = '%(APP_NAME)s'
default['gogs']['config']['mailer']['HOST'] = ''
default['gogs']['config']['mailer']['SKIP_VERIFY'] = ''
default['gogs']['config']['mailer']['USE_CERTIFICATE'] = false
default['gogs']['config']['mailer']['CERT_FILE'] = 'custom/mailer/cert.pem'
default['gogs']['config']['mailer']['KEY_FILE'] = 'custom/mailer/key.pem'
default['gogs']['config']['mailer']['FROM'] = ''
default['gogs']['config']['mailer']['USER'] = ''
default['gogs']['config']['mailer']['PASSWD'] = ''

default['gogs']['config']['oauth']['ENABLED'] = true

default['gogs']['config']['oauth.github']['CLIENT_ID'] = ''
default['gogs']['config']['oauth.github']['CLIENT_SECRET'] = ''
default['gogs']['config']['oauth.github']['ENABLED'] = true
default['gogs']['config']['oauth.github']['SCOPES'] = 'https://api.github.com/user'
default['gogs']['config']['oauth.github']['AUTH_URL'] = 'https://github.com/login/oauth/authorize'
default['gogs']['config']['oauth.github']['TOKEN_URL'] = 'https://github.com/login/oauth/access_token'

default['gogs']['config']['oauth.google']['ENABLED'] = false
default['gogs']['config']['oauth.google']['CLIENT_ID'] = ''
default['gogs']['config']['oauth.google']['CLIENT_SECRET'] = ''
default['gogs']['config']['oauth.google']['SCOPES'] =
'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile'
default['gogs']['config']['oauth.google']['AUTH_URL'] = 'https://accounts.google.com/o/oauth2/auth'
default['gogs']['config']['oauth.google']['TOKEN_URL'] = 'https://accounts.google.com/o/oauth2/token'

default['gogs']['config']['oauth.qq']['ENABLED'] = false
default['gogs']['config']['oauth.qq']['CLIENT_ID'] = ''
default['gogs']['config']['oauth.qq']['CLIENT_SECRET'] = ''
default['gogs']['config']['oauth.qq']['SCOPES'] = 'get_user_info'
default['gogs']['config']['oauth.qq']['AUTH_URL'] = 'https://graph.qq.com/oauth2.0/authorize'
default['gogs']['config']['oauth.qq']['TOKEN_URL'] = 'https://graph.qq.com/oauth2.0/token'

default['gogs']['config']['oauth.weibo']['ENABLED'] = false
default['gogs']['config']['oauth.weibo']['CLIENT_ID'] = ''
default['gogs']['config']['oauth.weibo']['CLIENT_SECRET'] = ''
default['gogs']['config']['oauth.weibo']['SCOPES'] = 'all'
default['gogs']['config']['oauth.weibo']['AUTH_URL'] = 'https://api.weibo.com/oauth2/authorize'
default['gogs']['config']['oauth.weibo']['TOKEN_URL'] = 'https://api.weibo.com/oauth2/access_token'

default['gogs']['config']['cache']['ADAPTER'] = 'memory'
default['gogs']['config']['cache']['INTERVAL'] = 60
default['gogs']['config']['cache']['HOST'] = ''

default['gogs']['config']['session']['PROVIDER'] = 'memory'
default['gogs']['config']['session']['PROVIDER_CONFIG'] = 'data/sessions'
default['gogs']['config']['session']['COOKIE_NAME'] = 'i_like_gogits'
default['gogs']['config']['session']['COOKIE_SECURE'] = false
default['gogs']['config']['session']['ENABLE_SET_COOKIE'] = true
default['gogs']['config']['session']['GC_INTERVAL_TIME'] = 86_400
default['gogs']['config']['session']['SESSION_LIFE_TIME'] = 86_400

default['gogs']['config']['picture']['SERVICE'] = 'server'
default['gogs']['config']['picture']['AVATAR_UPLOAD_PATH'] = 'data/avatars'
default['gogs']['config']['picture']['GRAVATAR_SOURCE'] = 'gravatar'
default['gogs']['config']['picture']['DISABLE_GRAVATAR'] = false

default['gogs']['config']['attachment']['ENABLE'] = true
default['gogs']['config']['attachment']['PATH'] = 'data/attachments'
default['gogs']['config']['attachment']['ALLOWED_TYPES'] = 'image/jpeg|image/png'
default['gogs']['config']['attachment']['MAX_SIZE'] = 32
default['gogs']['config']['attachment']['MAX_FILES'] = 10

default['gogs']['config']['time']['FORMAT'] = ''

default['gogs']['config']['log']['ROOT_PATH'] = ''
default['gogs']['config']['log']['MODE'] = 'file'
default['gogs']['config']['log']['BUFFER_LEN'] = 10_000
default['gogs']['config']['log']['LEVEL'] = 'Info'

default['gogs']['config']['log.console']['LEVEL'] = ''

default['gogs']['config']['log.file']['LEVEL'] = ''
default['gogs']['config']['log.file']['LOG_ROTATE'] = true
default['gogs']['config']['log.file']['MAX_LINES'] = 1_000_000
default['gogs']['config']['log.file']['MAX_SIZE_SHIFT'] = 28
default['gogs']['config']['log.file']['DAILY_ROTATE'] = true
default['gogs']['config']['log.file']['MAX_DAYS'] = 7

default['gogs']['config']['log.conn']['LEVEL'] = ''
default['gogs']['config']['log.conn']['RECONNECT_ON_MSG'] = false
default['gogs']['config']['log.conn']['RECONNECT'] = false
default['gogs']['config']['log.conn']['PROTOCOL'] = 'tcp'
default['gogs']['config']['log.conn']['ADDR'] = ''

default['gogs']['config']['og.smtp']['LEVEL'] = ''
default['gogs']['config']['og.smtp']['SUBJECT'] = 'Diagnostic message from serve'
default['gogs']['config']['og.smtp']['HOST'] = ''
default['gogs']['config']['og.smtp']['USER'] = ''
default['gogs']['config']['og.smtp']['PASSWD'] = ''
default['gogs']['config']['og.smtp']['RECEIVERS'] = ''

default['gogs']['config']['log.database']['LEVEL'] = ''
default['gogs']['config']['log.database']['DRIVER'] = ''
default['gogs']['config']['log.database']['CONN'] = ''

default['gogs']['config']['git']['MAX_GIT_DIFF_LINES'] = 10_000
default['gogs']['config']['git']['GC_ARGS'] = ''

default['gogs']['config']['git.fsck']['ENABLE'] = true
default['gogs']['config']['git.fsck']['INTERVAL'] = 24
default['gogs']['config']['git.fsck']['ARGS'] = ''

default['gogs']['config']['i18n']['LANGS'] =
'en-US,zh-CN,zh-HK,de-DE,fr-FR,nl-NL,lv-LV,ru-RU,ja-JP,es-ES,pt-BR,pl-PL'
default['gogs']['config']['i18n']['NAMES'] =
'English,简体中文,繁體中文,Deutsch,Français,Nederlands,Latviešu,Русский,日本语,Español,Português,Polski'

default['gogs']['config']['other']['SHOW_FOOTER_BRANDING'] = false
