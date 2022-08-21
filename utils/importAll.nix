# Pretty basic function to import all files in a list, because it looks nicer to
# do utils.importAll than this map operation
lib: nixFiles: map import nixFiles
