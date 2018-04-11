# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes):

Bander has_many reports & has_many birds_of_species; Species has many birds_of_species.

- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User): 

Birds_of_species belongs_to species, report & bander; Report belongs_to bander

- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients): 

Bander has_many species through birds_of_species; Species has_many banders through birds_of_species & reports through birds_of_species

- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity): 

Birds_of_species.number_banded

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item): 

All models include validations (bander, birds_of_species, report, species)

- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes): 

Report.by_total_banded, URL: /reports/by_total_banded

- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)

/banders/:id/reports/new & /banders/:id/reports/:id/edit, Species & BirdsOfSpecies

- [x] Include signup (how e.g. Devise): 

Hand coded, using new/create actions in banders controller along with bcrypt/has_secure_password

- [x] Include login (how e.g. Devise): 

Hand coded new/create actions in sessions controller

- [x] Include logout (how e.g. Devise): 

Hand coded destroy action in sessions controller

- [x] Include third party signup/login (how e.g. Devise/OmniAuth)

Google signup using OmniAuth

- [x] Include nested resource show or index (URL e.g. users/2/recipes)
/banders/:id/reports
/banders/:id/reports/:id

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)

/banders/:id/reports/new

- [x] Include form display of validation errors (form URL e.g. /recipes/new)

/login
/reports/new
/reports/edit

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
