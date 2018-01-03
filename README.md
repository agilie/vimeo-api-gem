<p align="center">
  <img width="600" style="vertical-align: middle" src="https://github.com/agilie/vimeo-api-gem/wiki/assets/title.png" alt="Vimeo API Client">
</p>

# Vimeo API Client

A Ruby wrapper for the Vimeo API. It utilizes v3 Vimeo API version.
For more detailed documentation please refer to the [Wiki](https://github.com/agilie/vimeo-api-gem/wiki) 
and [official Vimeo documentation](https://developer.vimeo.com/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vimeo_api_client', git: 'https://github.com/agilie/vimeo-api-gem', branch: :master
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vimeo_api_client
    
<p align="center"> 
    <img width="600" src="https://github.com/agilie/vimeo-api-gem/wiki/assets/main_logo.png" alt="Example">
</p>

## Usage

#### Universal API call

As long as not all the API endpoints are implemented in "Ruby Way" you can make any request 
with a universal wrapper i.e

```ruby
Vimeo.resource.get('/api/resource/id/etc')
```

Available actions are `get`, `post`, `put`, `patch` and `delete`

For example
```ruby
# Get all videos a user has liked
Vimeo.resource.get('/me/likes')

# Add video to an album
Vimeo.resource.put("/me/albums/#{album_id}/videos/#{video_id}")

# Delete a channel
Vimeo.resource.delete("/channels/#{channel_id}")
```

#### Working with resources

See more details on [Wiki](https://github.com/agilie/vimeo-api-gem/wiki/3-Resources)

Vimeo API workflow is based on a different resources such as **users**, 
**videos**, **albums**, **comments** etc. Each resource has its own
uri and methods. Almost all of them has standard **C**reate 
**R**ead **U**pdate **D**estroy actions.

You can build a resource on the basis of its uri and call appropriate action:

```ruby
# Get all albums of user with ID 12345
Vimeo.album('/users/12345/albums').index

# Delete my album with ID 67890
Vimeo.album('/me/albums/67890').destroy

```

Resource may have some specific actions, i.e.

```ruby
# Add videos to my album
Vimeo.album('/me/albums/67890').add_videos(['11111', '22222', '33333'])
```

As you can see the resources are nested. For example, **user** can have 
many **albums**, **video** can have many **comments** and so on. 
Using this, you can rewrite actions above in more natural way:

```ruby
# Get all albums of user with ID 12345
Vimeo.user('12345').albums.index

# Delete my album with ID 67890
Vimeo.user.album('67890').destroy

# Add videos to my album
Vimeo.user.album('67890').add_videos(['11111', '22222', '33333'])
```

## Author
This gem is open-sourced by [Agilie Team](https://www.agilie.com?utm_source=github&utm_medium=referral&utm_campaign=Git_Ruby&utm_term=vimeo-api-gem) ([info@agilie.com](mailto:info@agilie.com))

## Contributor
[Sergey Mell](https://github.com/SergeyMell)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/agilie/vimeo-api-gem. 
This project is intended to be a safe, welcoming space for collaboration and contributors.

## Contact us
If you have any questions, suggestions or just need a help with web or mobile development, 
please email us at <web@agilie.com>. You can ask us anything from basic to complex questions.

We will continue publishing new open-source projects. Stay with us, more updates will follow!

## License

The gem is available as open source under the [MIT](LICENSE.txt) 
License (MIT) Copyright © 2017 [Agilie Team](https://www.agilie.com?utm_source=github&utm_medium=referral&utm_campaign=Git_Ruby&utm_term=vimeo-api-gem)
