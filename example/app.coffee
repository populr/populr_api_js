step = require('stepc')
http = require('http')
fs = require('fs')
program = require('commander')

program
  .version('0.0.1')
  .option('-e, --environment [env]', 'Populr.me Environment')
  .parse(process.argv)

if (program.environment == 'development')
  populr = require('populr').config('LIIZAOPK-ITFEAWEB-HJYCKMPQ', 'api.lvh.me:3000')
else
  populr = require('populr').config('LIIZAOPK-ITFEAWEB-HJYCKMPQ')


uploaded_asset = null

step.async(
  () ->
    # upload an image asset
    filepath = '/Volumes/Big\ Disk/Pictures/Me/IMG002-square.png'
    buffer = new Buffer(fs.readFileSync(filepath))
    populr.images.post({'Content-Type':"multipart/form-data"}, {file: {data:buffer, name:"image.png", type:"image/png"}}, @)
  ,
  (err, image_asset) ->
    console.log image_asset
    throw err if err

    uploaded_asset = image_asset
    populr.templates.get(@)
  ,
  (err, templates) ->
    throw err if err

    console.log("Available API Templates:")
    for template in templates
      console.log("#{template.name} - #{template._id}")
      console.log("   #{template.api_tags}")

    data =
      "pop":
        "template_id": templates[0]._id,
        "name": "Node Pop",
        "title": "My New Pop",
        "label_names": [],
        "password": null

      "populate_tags":
        "first_name": "Ben",
        "last_name": "Gotow",
        "personal_site": "http://www.foundry376.com/"

      "populate_regions":
        "profile_image_region": uploaded_asset._id

    populr.pops.post(data, @)
  ,
  (err, pop) ->
    console.log(pop)
    throw err if err

    console.log(err) if err
    populr.pops(pop._id).publish.post({}, @)
  ,
  (err, response) ->
    if err || !response
      console.log('Exception:', err)
    else if (response.error)
      console.log('Error: ', response.error)
    else
      console.log('Success! Your pop is live:')
      console.log(response)
)

