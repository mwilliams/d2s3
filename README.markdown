# **d2s3**


d2s3 (direct to s3) is a simple helper that generates an upload form that will take a given file and upload it directly to your S3 bucket, bypassing your server.  This has various benefits, the biggest being that a large upload will not tie up your server from serving other requests.

### Example:

		<%= s3_http_upload_tag 	:key => 'uploads', 
								:content_type => 'image/jpeg', 
								:redirect => image_processing_url,
								:acl => 'public-read' 
								:max_filesize => 5.megabytes,
								:submit_button => '<input type="submit" value="Upload" class="button" id="upload-button">',
								:form => {:style => 'display: inline;'} %>

The above helper will generate the following similar HTML form, generating all of the appropriate field keys, policy, and signature based on your Amazon Web Services YAML configuration file.  The form parameter also accepts a class and id for further customization.  

		<form action="https://YOUR_S3_BUCKET.s3.amazonaws.com/" method="post" enctype="multipart/form-data" style="display: inline;">
		  <input type="hidden" name="key" value="uploads/${filename}">
		  <input type="hidden" name="AWSAccessKeyId" value="YOUR_AWS_ACCESS_KEY"> 
		  <input type="hidden" name="acl" value="private"> 
		  <input type="hidden" name="success_action_redirect" value="/image_processing_url">
		  <input type="hidden" name="policy" value="YOUR_POLICY_DOCUMENT_BASE64_ENCODED">
		  <input type="hidden" name="signature" value="YOUR_CALCULATED_SIGNATURE">
		  <input type="hidden" name="Content-Type" value="image/jpeg">
		  <input name="file" type="file"><input type="submit" value="Upload" class="button" id="upload-button">
		</form>
		

### **TODO**
* Write tests 

_**Matthew Williams, 2009**_

Thanks to the s3-swf-upload plugin which code was borrowed from to make this project work.  That project can be found at: http://github.com/elcgit/s3-swf-upload-plugin/tree/master
