package server

import "shared:common"

//Used in semantic tokens and inlay hints to handle the entire file being resolved.
FileResolveCache :: struct {
	files: map[string]map[uintptr]SymbolAndNode,
}

file_resolve_cache: FileResolveCache

resolve_entire_file_cached :: proc(document: ^common.Document) -> map[uintptr]SymbolAndNode{
	if document.uri.uri not_in file_resolve_cache.files {
		file_resolve_cache.files[document.uri.uri] = resolve_entire_file(
			document,
			common.scratch_allocator(document.allocator),
		)
	}	

	return file_resolve_cache.files[document.uri.uri];
}
