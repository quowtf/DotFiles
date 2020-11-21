# Use TinyPNG https://tinypng.com/ api to reduce almost any image file size
# Require
#  exiftools to remove metadata from images before uploading
#  an api key from TinyPNG, if you have one can be set with 
#    set -g -x API_KEY_TINYPNG '{YOUR_API_KEY}'
# Example
#  reduce ../images/big.jpg

function reduce --description ''
    command exiftool -all= $argv[1]
    set -l file_ext (basename $argv[1] | cut -d '.' -f 2)
    set -l file_name (basename $argv[1] | cut -d '.' -f 1)
    set -l new_file "$file_name.reduced.$file_ext"
    curl --user api:$API_KEY_TINYPNG --output $new_file ( curl --user api:$API_KEY_TINYPNG --data-binary @$argv[1] -i https://api.tinify.com/shrink | grep location | cut -d ' ' -f 2 | tr -d '\r' )
end
