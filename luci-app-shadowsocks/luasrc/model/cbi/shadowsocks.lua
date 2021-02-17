--[[
--Shadowsocks Client configuration page By Owen. 
--
]]--

local fs = require "nixio.fs"

local state_msg = ""
local ss_local_on = (luci.sys.call("pidof sslocal > /dev/null") == 0)
if ss_local_on then	
	state_msg = "<b><font color=\"green\">" .. translate("Running") .. "</font></b>"
else
	state_msg = "<b><font color=\"red\">" .. translate("Not running") .. "</font></b>"
end

m = Map("shadowsocks", translate("Shadowsocks Socks5 Proxy"),
        translatef("A fast tunnel proxy that help you get through firewalls.").. " - " .. state_msg)

s = m:section(TypedSection, "shadowsocks", translate("Settings"))
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

timeout = s:option(Value, "timeout", translate("Timeout"))
timeout.optional = false

password = s:option(Value, "password", translate("Password"))
password.password = true

cipher = s:option(ListValue, "method", translate("Cipher Method"))
cipher:value("table")
cipher:value("rc4")
cipher:value("rc4-md5")
cipher:value("aes-128-cfb")
cipher:value("aes-192-cfb")
cipher:value("aes-256-cfb")
cipher:value("bf-cfb")
cipher:value("cast5-cfb")
cipher:value("des-cfb")
cipher:value("camellia-128-cfb")
cipher:value("camellia-192-cfb")
cipher:value("camellia-256-cfb")
cipher:value("idea-cfb")
cipher:value("rc2-cfb")
cipher:value("seed-cfb")
cipher:value("salsa20")
cipher:value("chacha20")



local apply = luci.http.formvalue("cbi.apply")
if apply then
	os.execute("/etc/init.d/ssrlocal restart >/dev/null 2>&1 &")
end



return m


