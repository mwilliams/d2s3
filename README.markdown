# **d2s3**


d2s3 (direct to s3) is a simple helper that generates an upload form that will take a given file and upload it directly to your S3 bucket, bypassing your server.  This has various benefits, the biggest being that an upload will not tie up your server.

### Example:

		<%= s3_http_upload_tag 	:key => 'uploads', 
														:content_type => 'image/jpeg', 
														:redirect => image_processing_url,
														:acl => 'public-read' %>

Most of the options are optional.

_**Matthew Williams, 2009**_

Much thanks to the s3-swf-upload plugin which code was borrowed from to make this project work.  That project can be found at: http://github.com/elcgit/s3-swf-upload-plugin/tree/master
