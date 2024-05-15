#!/bin/bash

# Startnachricht
echo "################################################################################"
echo "# UniFi Third-Party-SIP Script                                                 #"
echo "################################################################################"
echo "# Script was developed by Jan Heil.                                            #"
echo "#                                                                              #"
echo "# Unofficial German UI Forum:                                                  #"
echo "# https://ubiquiti-networks-forum.de/user/115-jaxnprivate/                     #"
echo "#                                                                              #"
echo "# UI Forum:                                                                    #"
echo "# https://community.ui.com/user/JanFX2003/a521c964-0aba-4ad4-89aa-b42b5066e8a5 #"
echo "################################################################################"

# Setzt den Standard Domainnamen
defaultDomain="tel.t-online.de"

# Erfragt den neuen Domainnamen vom Benutzer, verwendet den Standard Domainnamen wenn keine Eingabe gemacht wird
echo "Please enter SIP-Domain of your Provider (Default: ${defaultDomain}):"
read newDomain

# Prüft ob eine Eingabe gemacht wurde, wenn nicht wird der Standard Domainname verwendet
if [ -z "$newDomain" ]
then
  newDomain=$defaultDomain
fi

# Ein Backup der server.js Datei erstellen
echo "Creating a Backup of the server.js File (/usr/share/unifi-talk/app/server.js.bak)..."
cp -f /usr/share/unifi-talk/app/server.js /usr/share/unifi-talk/app/server.js.bak

# Ersetzt @talk.com durch den neuen Domainnamen in der Datei server.js
sed -i "/sip_from_uri/ s/@talk.com/@${newDomain}/g" /usr/share/unifi-talk/app/server.js
echo "Replaced '@talk.com' given SIP-Provider Domain."

# Unifi-Talk Service neustarten
echo "Restarting UniFi-Talk Service."
service unifi-talk restart