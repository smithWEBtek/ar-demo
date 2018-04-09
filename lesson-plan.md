# ActiveRecord for Rails

## Getting Set Up - ~5 minutes preparation

Before the group begins, you may want to decide on a domain with a few models that will be related and generate a new rails app with a few models to demonstrate it. Feel free to clone [this repo created for the purpose](https://github.com/weezwo/ar-demo).


This document will use Song, Artist, Genre, and SongGenre as examples, with the following presumed relationships (build these with students during the group):

- Artist
  - has_many :songs


- Song
  - belongs_to :artist
  - has_many :song_genres
  - has_many :genres, through: :song_genres


- Genre
  - has_many :song_genres
  - has_many :songs, through: :song_genres


- SongGenre
  - belongs_to :song
  - belongs_to :genre

***

## ActiveRecord Relationships ~15 minutes

### Setup - 5-7 minutes

Take a few minutes to set up these relationships with students. Ideally, you will tell them about the domain and your models, and they will be able to tell you which relationships should go on each model. Talk about why each relationship is appropriate for each model, especially with regards to whether they are one-to-many and many-to-many relationships.

### Methods - 8-10 minutes

Ask students to describe some of the methods we have created by adding these relationship macros to our models. Emphasize that all  these relationship macros do is add methods to your models.

After students have discussed a few of these (perhaps with a bit of prodding) and you have used the console to demonstrate that the methods exist, link to these association references:

http://guides.rubyonrails.org/association_basics.html#belongs-to-association-reference

http://guides.rubyonrails.org/association_basics.html#has-many-association-reference

Talk through the methods that will be relevant to students and demonstrate their usage in the console.

You may want to remove the relationships and `reload!` the console to demonstrate that it is the relationship macros that make these methods available.

***

## CRUD in ActiveRecord - ~15 minutes

In the directory of any Rails app, run the rails console and lead students through several CRUD-related questions and tasks. Use the console to demonstrate, but allow students to give the answer and tell you what to type when possible. Do not feel obligated to "stick to the script" here. Feel free to tailor your questions to the group and the previous answers they've given.

### Creation - 2-3 minutes

- How can we instantiate a new artist without saving it in the database?
- How can we instantiate a new artist with a certain attribute?
- How can we save this object in the database?
- What are the differences between `.new` and `.create`?
- What does `#save` do?
- What is the difference between chaining .new.save and calling .create?
- Of `.new`, `.create`, and `#save`, which come from ActiveRecord?


- How can we instantiate a new song belonging to our artist? (`artist.songs.build`)
- How can we instantiate and save a new new song belonging to our artist? (`artist.songs.create`)

### Updating - 1 minute

- How can we use ActiveRecord to update one or multiple attributes of an object? (#update)

If a student brings up #update_attributes, let them know that while this will work, the method has been deprecated.

### Deleting - 1-2 minutes

- How can we use ActiveRecord to destroy one song? (`#destroy`)
- How can we use ActiveRecord to destroy all songs? (`.destroy_all`)
- How can we use ActiveRecord to destroy all songs belonging to a particular artist? - Demonstrate that `.destroy_all` is chainable.

### Reading / ActiveRecord Query Methods - 5-7 minutes

Note that we've saved the "R" in CRUD for last. What we are really discussing here are ActiveRecord's powerful query methods, which allow us to grab one or many objects based on nearly any criteria imaginable. Create a few objects or use the ones you've already made. Get students to find objects using `.find`, `.find_by`, and `.where`.

- How do we find the song with id 3?
- How do we find all songs belonging to a particular artist?
- How do we find a song given a certain title?
- How do we find a list of songs whose title contains the letter T? (`Song.where('title like ?', '%t%')`)
- How do we find a list of songs belonging to a certain artist and with a certain genre?

***

## ActiveRecord Validations - ~15 minutes

### Why Validate? - 3 minutes
Ask students for their takes on the importance of validation. If not brought up, be sure to mention:
- Validations protect our database from "junk" data.
- Validations ensure that data required by our application is never missing. Perhaps...
  - A view will break if a certain object doesn’t have a “name”
  - A certain calculation can’t be performed if a value is not a number
  - A slug method will return the wrong object if there are two objects with the same “name” attribute

Talk about where ActiveRecord validations "go" — i.e. on the model. Take some time also to outline the benefits of validation at the level of the model.

- Keeps business logic out of controllers
- Ensures that there can be no unwanted bypass of validation — even when creating records in the console.

### The Anatomy of a Validation - 1-2 minutes

```ruby
validates :name, length: {minimum: 5}
```
1. Call to ActiveRecord::Base’s #validates method (`validates`)
2. First argument: Attribute to validate as symbol (`:name`)
3. Validation helper as keyword argument (`length:`)
4. Options block: in some cases, will be replaced simply by “true” (`{minimum: 5}`)

If asked, mention that syntax such as `validates_uniqueness_of` is valid, but deprecated.

### Validation Helpers - 5 minutes

Link students to the rails guide on validations [here](http://guides.rubyonrails.org/active_record_validations.html). Present some exercises to get them using these guides to write 3-5 validations as a group. Here are a few examples for a `User` model (you may choose to generate one if using the [demo repo](https://github.com/weezwo/ar-demo)):

- Validate that `username` is present
  - `validates :username, presence: true`
- Validate that `email` is unique
  - `validates :email, uniqueness: true`
- Validate that `email` is unique, case insensitive
  - `validates :email, uniqueness: {case_sensitive: false}`
- Validate that `alignment` is one of Good, Neutral, or Evil
  - `validations :alignment, inclusion: {in: %w(Good Neutral Evil)}`
- Validates that `age` is a number
  - `validates :age, numericality: true`
  - `validates :age, format: {with: /\A\d+\z/}`
- Validate that `age` is an integer at least 13 and less than 150
  - `validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 13, less_than: 150}`
- Validates that `name` consists only of alphabetical characters
  - `validates :age, format: {with: /\A[A-Za-z]\z/}`
- Validates that `name` is not Steve, with error message "can't be Steve."
  - `validates :name, exclusion: {in: %w(Steve), message: "can't be Steve."}`
- Validates that `name` does not include Steve
  - `valdates :name, format: {without: /[Ss]teve/}`
- Validates that password is at least 5 characters long
  - `validates :password_digest, length: {minimum: 5}`

### When Does Validation Occur? - 1 minute

Demonstrate that validation only occurs upon an attempt to persist an object, or when calling `#valid?`.

### #errors and #errors.full_messages - 2 minutes

Demonstrate that, after a failed validation, one can view the errors preventing the record from being saved by calling `#errors` on that object. Calling `.errors.full_messages` will return an array of formatted errors that can be iterated over in the view to display errors to the user. Fancy stuff!! Note also that, before validation occurs (see above), `#errors` will contain no errors.

***

## Questions and Discussion - ~15 minutes

Of course, you do not need to save this for the end. Build a portion of this time into your discussion if questions or sidebars arise.