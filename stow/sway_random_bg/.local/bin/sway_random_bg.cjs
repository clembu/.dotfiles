#!/usr/bin/env node

const { env } = require('node:process')
const net = require('node:net')
const os = require('node:os')
const path = require('node:path')
const fs = require('node:fs')
const cp = require('node:child_process')

const endianness = os.endianness()

const wpfiles = {
    h: {
        path: path.join(env.WALLPAPERS_DIR, 'h/'),
        files: fs.readdirSync(path.join(env.WALLPAPERS_DIR, 'h/'))
    },
    v: {
        path: path.join(env.WALLPAPERS_DIR, 'v/'),
        files: fs.readdirSync(path.join(env.WALLPAPERS_DIR, 'v/'))
    }
}

function random_in_array(arr) {
    const idx = Math.round(Math.random() * (arr.length - 1))
    return arr[idx]
}

/**
    * Get a random wallpaper filepath, given a direction
    * @param {'h'|'v'} dir
    */
function get_random_wp(dir) {
    switch (dir) {
        case 'h':
            return path.join(wpfiles.h.path, random_in_array(wpfiles.h.files))
        case 'v':
            return path.join(wpfiles.v.path, random_in_array(wpfiles.v.files))
    }
}

const wallpapers = {}
const outputs = {}

/** Wrapper around Buffer.writeUInt32LE and Buffer.writeUInt32BE
    * @param {Buffer} buf The buffer to write into
    * @param {number} i The value to write
    * @param {number} offset The offset to write at
    */
function writeU32(buf, i, offset) {
    switch (endianness) {
        case 'LE':
            return buf.writeUInt32LE(i, offset)
        case 'BE':
            return buf.writeUInt32BE(i, offset)
    }
}

const messages = {
    get_version() {
        const buf = Buffer.alloc(14)
        buf.write('i3-ipc', 0)
        writeU32(buf, 0, 6)
        writeU32(buf, 7, 10)
        return buf
    },
    get_outputs() {
        const buf = Buffer.alloc(14)
        buf.write('i3-ipc', 0)
        writeU32(buf, 0, 6)
        writeU32(buf, 3, 10)
        return buf
    },
    subscribe_workspaces() {
        const buf = Buffer.alloc(28)
        buf.write('i3-ipc', 0) //6
        writeU32(buf, 14, 6) //10
        writeU32(buf, 2, 10) //14
        buf.write('["workspace"]', 14) //28
        return buf
    }
}


/** Wrapper around Buffer.readUInt32LE and Buffer.readUInt32BE
    * @param {Buffer} buf The buffer to read from
    * @param {number} offset The offset to read at
    */
function readU32(buf, offset) {
    switch (endianness) {
        case 'LE':
            return buf.readUInt32LE(offset)
        case 'BE':
            return buf.readUInt32BE(offset)
    }
}

/** Read an IPC reply from a buffer
    * @param {Buffer} buf The buffer to read from
    */
function readReply(buf) {
    const len = readU32(buf, 6)
    const ty = readU32(buf, 10)
    const payload = buf.subarray(14, 14 + len).toString()
    return { message_type: ty, data: JSON.parse(payload) }
}

const sockpath = env.SWAYSOCK
const socket = net.createConnection(sockpath, init)

function init() {
    const buf = messages.get_outputs()
    socket.write(buf, (err) => {
        if (err) {
            socket.emit('close')
            throw err
        }
        socket.once('data', onGetOutputs)
    })
}

function onGetOutputs(data) {
    const msg = readReply(data)
    for (const o of msg.data) {
        let dir = o.rect.width < o.rect.height ? "v" : "h"
        outputs[o.name] = dir
        wallpapers[o.name] = get_random_wp(dir)
    }
    set_wallpapers()
    const buf = messages.subscribe_workspaces()
    socket.write(buf, (err) => {
        if (err) { socket.emit('close'); throw err }
        socket.on('data', onWorkspace)
    })
}

function onWorkspace(data) {
    const msg = readReply(data)
    if (msg.data.current && msg.data.current.output) {
        const o = msg.data.current.output
        wallpapers[o] = get_random_wp(outputs[o])
        set_wallpapers()
    }
}

function sleep(s) {
    return new Promise(resolve => setTimeout(resolve, s*1000))
}

async function set_wallpapers() {
    const args = Object.entries(wallpapers).flatMap(([key,value]) => {
        return ["-o", key, "-i", value, "-m", "fill"]
    })
    let pids = []
    try {
     pids = cp.execFileSync("pidof", ["swaybg"]).toString().trim().split(' ')
    } catch (_) {}
    cp.spawn("swaybg", args)
    await sleep(1)
    if (pids.length > 0) {
        cp.spawnSync("kill", pids)
    }
}
