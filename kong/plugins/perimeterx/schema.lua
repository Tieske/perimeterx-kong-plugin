local Errors = require "kong.dao.errors"

return {
    no_consumer = true, -- this plugin will only be API-wide,
    fields = {
        px_appId = {type = "string", required = true},
        cookie_secret = {type = "string", required = true},
        auth_token = {type = "string", required = true},
        blocking_score = {type = "number", default = 100},
        px_debug = {type = "boolean", default = false},
        block_enabled = {type = "boolean", default = false},
        sensitive_headers = {type = "array", default = {'cookie', 'cookies'}},
        ip_headers = {type = "array", default = {}},
        s2s_timeout = {type = "number", default = 1000},
        client_timeout = {type = "number", default = 2000},
        send_page_requested_activity = {type = "boolean", default = true},
        score_header_name = {type = "string", default = 'X-PX-SCORE'},
        sensitive_routes_prefix = {type = "array", default = {}},
        sensitive_routes_suffix = {type = "array", default = {}},
        enabled_routes = {type = "array", default = {}},
        first_party_enabled = {type = "boolean", default = true},
        reverse_xhr_enabled = {type = "boolean", default = true},

        custom_block_url = {type = "string"},
        api_protection_mode = {type = "boolean", default = false},
        api_protection_block_url = {type = "string"},
        api_protection_default_redirect_url = {type = "string"},
        redirect_on_custom_url = {type = "boolean", default = false},
        custom_logo = {type = "string"},
        css_ref = {type = "string"},
        js_ref = {type = "string"},
        -- ## END - Configuration block ##

        -- ## Filter Configuration ##

        whitelist_uri_full = {type = "array", default = {}}, -- custom_block_url value should be a member of this array
        whitelist_uri_prefixes = {type = "array", default = {}},
        whitelist_uri_suffixes = {type = "array", default = { '.css', '.bmp', '.tif', '.ttf', '.docx', '.woff2', '.js', '.pict', '.tiff', '.eot', '.xlsx', '.jpg', '.csv', '.eps', '.woff', '.xls', '.jpeg', '.doc', '.ejs', '.otf', '.pptx', '.gif', '.pdf', '.swf', '.svg', '.ps', '.ico', '.pls', '.midi', '.svgz', '.class', '.png', '.ppt', '.mid', 'webp', '.jar' }},
        whitelist_ip_addresses = {type = "array", default = {}},
        whitelist_ua_full = {type = "array", default = {}},
        whitelist_ua_sub = {type = "array", default = {}}
    },
    self_check = function(schema, plugin_t, dao, is_updating)
        -- perform any custom verification
        local config = plugin_t

        if config.api_protection_mode then
            if config.api_protection_block_url == nil or config.api_protection_block_url == '' or config.api_protection_default_redirect_url == nil or config.api_protection_default_redirect_url == '' then
                return false, Errors.schema "API protection mode requires setting values for api_protection_block_url and api_protection_default_redirect_url"
            end
        end
        return true
    end
}
