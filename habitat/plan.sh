pkg_name=assoc
pkg_origin=greenfork
pkg_version=0.1.0
pkg_scaffolding=core/scaffolding-ruby
pkg_deps=(
    core/mysql-client
)
pkg_exports=(
    [port]=server.port
)
pkg_exposes=(
    port
)
pkg_binds_optional=(
    [database]="port password username"
)
pkg_interpreters=(/bin/bash)
pkg_bin_dirs=(bin)

declare -A scaffolding_env
scaffolding_env[PORT]={{cfg.server.port}}
scaffolding_env[HANAMI_ENV]={{cfg.app.hanami_env}}
scaffolding_env[WEB_SESSIONS_SECRET]={{cfg.app.web_session_secret}}
scaffolding_env[RESEARCH_SESSIONS_SECRET]={{cfg.app.research_session_secret}}
scaffolding_env[SMTP_HOST]={{cfg.mail.host}}
scaffolding_env[SMTP_PORT]={{cfg.mail.port}}
scaffolding_env[HOST_URI]={{cfg.server.uri}}
scaffolding_env[DATABASE_URL]={{cfg.database.url}}
scaffolding_env[LANG]={{cfg.lang}}
scaffolding_env[SVC_FOLDER]="/hab/svc/$pkg_name"
scaffolding_env[SERVE_STATIC_ASSETS]="true"
