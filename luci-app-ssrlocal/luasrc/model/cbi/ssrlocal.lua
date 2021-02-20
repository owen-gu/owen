
local fs = require "nixio.fs"
local o,s,m


local state_msg = ""
local ssrlocal_on = (luci.sys.call("pidof ssrlocal > /dev/null") == 0)
if ssrlocal_on then	
	state_msg = "<b><font color=\"green\">" .. translate("Running") .. "</font></b>"
else
	state_msg = "<b><font color=\"red\">" .. translate("Not running") .. "</font></b>"
end

m = Map("ssrlocal", translate("ShadowsocksR Socks5 Proxy"),
	translate("ShadowsocksR Socks5 Proxy that help you get through firewalls on your router") .. " - " .. state_msg)

s = m:section(TypedSection, "ssrlocal", translate("Settings"))
s.anonymous = true

switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false

server = s:option(Value, "server", translate("Server Address"))
server.optional = false

server_port = s:option(Value, "server_port", translate("Server Port"))
server_port.datatype = "range(0,65535)"
server_port.optional = false

local_port = s:option(Value, "local_port", translate("Local Port"))
local_port.datatype = "range(0,65535)"
local_port.optional = false

password = s:option(Value, "password", translate("Password"))
password.password = true

method = s:option(ListValue, "method", translate("Encryption Method"))
method:value("none")
method:value("table")
method:value("rc4")
method:value("rc4-md5")
method:value("aes-128-cfb")
method:value("aes-192-cfb")
method:value("aes-256-cfb")
method:value("bf-cfb")
method:value("camellia-128-cfb")
method:value("camellia-192-cfb")
method:value("camellia-256-cfb")
method:value("cast5-cfb")
method:value("des-cfb")
method:value("idea-cfb")
method:value("rc2-cfb")
method:value("seed-cfb")
method:value("salsa20")
method:value("chacha20")
method:value("chacha20-ietf")

timeout = s:option(Value, "timeout", translate("Timeout"))
timeout.optional = false

protocol = s:option(ListValue, "protocol", translate("Protocol"))
protocol:value("origin")
protocol:value("auth_chain_a")
protocol:value("auth_chain_b")
protocol:value("auth_chain_c")
protocol:value("auth_chain_d")
protocol:value("auth_chain_e")
protocol:value("auth_chain_f")
protocol:value("verify_simple")
protocol:value("verify_deflate")
protocol:value("verify_sha1")
protocol:value("auth_simple")
protocol:value("auth_sha1")
protocol:value("auth_sha1_v2")
protocol:value("auth_sha1_v4")

protocol_param = s:option(Value, "protocol_param", translate("Protocol Param"),
	translate("leave it empty is well"))




obfs = s:option(ListValue, "obfs", translate("Obfs"))
obfs:value("plain")
obfs:value("http_simple")
obfs:value("random_head")
obfs:value("tls1.2_ticket_auth")


obfs_param= s:option(Value, "obfs_param", translate("Obfs Param"),
	translate("leave it empty is well"))





local apply = luci.http.formvalue("cbi.apply")
if apply then
	os.execute("/etc/init.d/ssrlocal restart >/dev/null 2>&1 &")
end

return m

