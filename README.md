
# tsmconsole

Tsmodem helper module is used to provide websocket support for "Web-console of AT-commands feature".

## Ubus objects

_**tsmodem.console**_ object is created with one method "session".
The session keeps ubus_rpc_session of that user who logged in to the web-interface of OpenWrt router.

Also the session keeps state of Web-console popup window opened/closed in the Web UI of OpenWrt router.

## Poll the websocket

Tsmconsole polls websocket and call _**tsmodem.driver send_at**_ method, sending AT-command as a parameter.

## Subscribe AT-response

Since GSM-modem answers to the AT-command, tsmconsole catches the response by subscription, so tsmconsle is a subscriber of _**tsmodem.driver**_ ubus object. Then the AT-response is sent back to the Web-browser by the websocket.
