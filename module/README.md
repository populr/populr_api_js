# Populr.me API JS

The Populr javascipt module wraps the Populr.me API so that it can be used easily from a Node.js app. Currently, the module is based on Fermata, which makes it easy to encapsulate a REST API. Pull requests are welcome.


## Performing Common Tasks

### Initialization

	var populr = require('populr').config('LIIZAOPK-ITFEAWEB-HJYCKMPQ')

### Creating an Asset

    # upload an image asset
    var filepath = '/Volumes/Big\ Disk/Pictures/Me/IMG002-square.png';
    var buffer = new Buffer(fs.readFileSync(filepath));
    populr.images.post({'Content-Type':"multipart/form-data"}, {file: {data:buffer, name:"image.png", type:"image/png"}}, function(err, asset) {

    });


### Identifying Available Templates

    populr.templates.get(function(err, templates) {
      throw err if err

      console.log("Available API Templates:");
      for (template in templates) {
        console.log(template.name + " - " + template._id);
        console.log("   " + template.api_tags);
	});
	
	
### Creating a Pop

    var data = {
      "pop":{
        "template_id": templates[0]._id,
        "name": "Node Pop",
        "title": "My New Pop",
        "label_names": [],
        "password": null
  	  },
      "populate_tags": {
        "first_name": "Ben",
        "last_name": "Gotow",
        "personal_site": "http://www.foundry376.com/"
  	  },
      "populate_regions": {
        "profile_image_region": uploaded_asset._id
      }
    };
    populr.pops.post(data, function(err, pop) {

    });

### Publishing a Pop

    populr.pops(pop._id).publish.post({}, function(err) {

    });


## Running the Sample App

To run the sample code, navigate into the example directory and run `sudo npm install`. Then run `coffee app.coffee`. 

*Note: If you're a member of the Populr internal team and would like to point the API at your local machine instead of https://api.populr.me/, run with the envionment option: `coffee app.coffee -e development`*