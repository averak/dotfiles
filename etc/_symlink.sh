#!/usr/bin/env bash

_symlink() {
	local _source=$1
	local _target=$2
	local _backup

	if [ ! -e "$_source" ] && [ ! -L "$_source" ]; then
		_log_error "symlink source does not exist: '$_source'"
		return 1
	fi

	if [ -L "$_target" ] && [ "$(readlink "$_target")" = "$_source" ]; then
		return 0
	fi

	if [ -e "$_target" ] || [ -L "$_target" ]; then
		# Preserve the target path because different tools can have identically named skills.
		_backup=$_BACKUP_DIR/${_target#/}
		if [ -e "$_backup" ] || [ -L "$_backup" ]; then
			_log_error "backup target already exists: '$_backup'"
			return 1
		fi
		mkdir -p "$(dirname "$_backup")" || return 1
		_log_info "backup '$_target' to '$_backup'"
		mv "$_target" "$_backup" || return 1
	fi

	mkdir -p "$(dirname "$_target")" || return 1
	_log_info "ln -s '$_source' '$_target'"
	ln -s "$_source" "$_target"
}
