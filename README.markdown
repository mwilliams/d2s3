# **d2s3 (Direct to S3)**
The d2s3 (direct to s3) gem adds is a simple Ruby on Rails helper that generates an upload form that will take a given file and upload it directly to your S3 bucket, bypassing your server.  This has various benefits, the biggest being that a large upload will not tie up your server from serving other requests.  This gem is based on the instructions from the following Amazon tutorial: [http://developer.amazonwebservices.com/connect/entry.jspa?externalID=1434](http://developer.amazonwebservices.com/connect/entry.jspa?externalID=1434/ "Browser Uploads to S3 using HTML POST Forms")

### Why?
This was built as a solution to a problem we had where images being uploaded to be processed by [Paperclip](http://thoughtbot.com/projects/paperclip "Thoughtbot - Paperclip") were consuming [Thin](http://code.macournoyer.com/thin/ "Thin - Another Web Server") servers so they were unable to process other requests.

#### Install:

	gem install d2s3

#### An example workflow using d2s3
 1. Upload file with the `s3_http_upload_tag` helper form tag
 2. With the data returned from the GET HTTP request from Amazon, create a message using Amazon's SQS service with the appropriate information needed to later process the image with [Paperclip](http://thoughtbot.com/projects/paperclip "Thoughtbot - Paperclip")
 3. Create an API end point for a background process to access that accepts information to process the image with Paperclip.  In our case, it accepts the ID of a photo album and the path to the photo to be processed
 4. Running a back end process that monitors the SQS queue for new images and processes them immediately

We don't have immediate processing of our images with this workflow, but it's very quick assuming how large the queue is and how many back end processes we have actually running through the queue.

### Example d2s3 usage
```ruby
<%= s3_http_upload_tag 	:key => 'uploads',
			:content_type => 'image/jpeg',
			:redirect => image_processing_url,
			:acl => 'public-read',
			:max_filesize => 5.megabytes,
			:submit_button => '<input type="submit" value="Upload" class="button" id="upload-button">',
			:form => {:style => 'display: inline;'} %>
```
The above helper will generate the following similar HTML form, generating all of the appropriate field keys, policy, and signature based on your Amazon Web Services YAML configuration file. The form parameter also accepts a class and id for further customization.
```html
<form action="https://YOUR_S3_BUCKET.s3.amazonaws.com/" method="post" enctype="multipart/form-data" style="display: inline;">
  <input type="hidden" name="key" value="uploads/${filename}">
  <input type="hidden" name="AWSAccessKeyId" value="YOUR_AWS_ACCESS_KEY">
  <input type="hidden" name="acl" value="public-read">
  <input type="hidden" name="success_action_redirect" value="/image_processing_url">
  <input type="hidden" name="policy" value="YOUR_POLICY_DOCUMENT_BASE64_ENCODED">
  <input type="hidden" name="signature" value="YOUR_CALCULATED_SIGNATURE">
  <input type="hidden" name="Content-Type" value="image/jpeg">
  <input name="file" type="file"><input type="submit" value="Upload" class="button" id="upload-button">
</form>
```
### Return HTTP GET request from Amazon made to the redirect you declared
    Parameters: {"bucket"=>"BUCKET_NAME",
                 "etag"=>"ETAG_HASH",
                 "action"=>"YOUR_REDIRECT_URL",
                 "controller"=>"CONTROLLER",
                 "key"=>"PATH/FILENAME.EXTENSION"}

### Options:
* **:content_type**
  * Accepts a standard content type, otherwise it will default to binary/octet-stream
* **:redirect**
  * Directs the form where the GET request from Amazon should be made once the HTTP POST is successful
* **:success\_action\_status**
  * The status code returned to the client upon successful upload if success_action_redirect is not specified. Accepts 200, 201 and 204. Defaults to 204
* **:acl**
  * Accepts either 'public-read' or 'private'.  If blank, it defaults to 'public-read'
* **:expiration_date**
  * Accepts time in the form of "3.hours" or "25.minutes".  If blank, it defaults to a 10 hour window before the policy on the upload expires
* **:max_filesize**
  * Accepts a max file size in the format of "5.megabytes".  If blank, it defaults to 1.megabyte
* **:submit_button**
  * Accepts any text to represent the submit button for the form.  This allows for a very custom submit button.  If blank, it defaults to `<input type="submit" value="Upload">`
* **:form => {:id => '', :class => '', :style => ''}**
  * Accepts a hash of :class, :id, and :style to add customization to the form as a whole

### **Contributors**
* _**Matthew Williams**_
* _**Gabriel Cebrian**_
* _**Patrick Jones**_

Thanks to the [s3-swf-upload](http://github.com/elcgit/s3-swf-upload-plugin/tree/master "s3-swf-upload GitHub Project Page") plugin which code was borrowed from to make this project happen.
