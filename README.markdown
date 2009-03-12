# **d2s3**


d2s3 (direct to s3) is a simple helper that generates an upload form that will take a given file and upload it directly to your S3 bucket, bypassing your server.  This has various benefits, the biggest being that an upload will not tie up your server.

### Example:

		<%= s3_http_upload_tag 	:key => 'uploads', 
								:content_type => 'image/jpeg', 
								:redirect => image_processing_url,
								:acl => 'public-read' %>

The above helper will generate the following similar HTML form, generating all of the appropriate field keys, policy, and signature based on your Amazon Web Services YAML configuration file.

		<form action="https://YOUR_S3_BUCKET.s3.amazonaws.com/" method="post" enctype="multipart/form-data">
		  <input type="hidden" name="key" value="uploads/${filename}">
		  <input type="hidden" name="AWSAccessKeyId" value="YOUR_AWS_ACCESS_KEY"> 
		  <input type="hidden" name="acl" value="private"> 
		  <input type="hidden" name="success_action_redirect" value="/image_processing_url">
		  <input type="hidden" name="policy" value="YOUR_POLICY_DOCUMENT_BASE64_ENCODED">
		  <input type="hidden" name="signature" value="YOUR_CALCULATED_SIGNATURE">
		  <input type="hidden" name="Content-Type" value="image/jpeg">
		  File to upload to S3: 
		  <input name="file" type="file"> 
		  <br> 
		  <input type="submit" value="Upload File to S3"> 
		</form>
		

### **TODO**
* Add theme support
	* Example, passing :theme => :multiple as an option to provide a "Add File" button to instantiate another instance of the uploader, or :count => 3 to provide 3 file upload instances.
	* Templating.  Designing a template that the form would be based on and could be called with :template => :file\_upload.
* Add progress indicator
* Write tests 

_**Matthew Williams, 2009**_

Much thanks to the s3-swf-upload plugin which code was borrowed from to make this project work.  That project can be found at: http://github.com/elcgit/s3-swf-upload-plugin/tree/master
