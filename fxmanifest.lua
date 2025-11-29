fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

name 'rex-fishmonger'
author 'RexShackGaming'
description 'Fishmonger for RSG Framework'
version '2.1.0'
url 'https://discord.gg/YUV7ebzkqs'

client_scripts {
    'client/client.lua',
    'client/npcs.lua',
}

server_scripts {
    'server/server.lua',
    'server/versionchecker.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

dependencies {
    'rsg-core',
    'ox_lib',
}

files {
  'locales/*.json'
}

lua54 'yes'
