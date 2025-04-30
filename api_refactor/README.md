# README

Welcome to the API for ConneXion, a simple Question and Answer app.


#### Requirements for Questions
* Any registered user can ask a question
* Searchable tags can be assigned to questions. Any user can assign a tag to a question.
* Questions can only be deleted and edited (except for tags) by the user who asked the question
* Users receive a welcome email after asking their first Question
* Questions can be rated on a scale of 1-5 by any user

#### Requirements for Question Responses
* Registered users can respond to any question
* Responses can only be edited or deleted by the user who created the response
* Responses can be rated on a scale of 1-5 by any user
* When a question is responded to, the user who created the question will get an email to let them know


#### What the Frontend wants
The frontend would like to present a list of all questions to the user, and also give the user the ability to search this list by tag(s). When listing questions, they should be sorted by their average rating. When listing questions the frontend would like to show the question text, the username and title of the user who asked it, and its average rating.

When displaying a single question (as oppose to a list of questions), the frontend would like to show the question text, the username and title of the user who asked it, its average rating, and its tags. As well as the question's responses. The responses should also be sorted by their average rating, and display their text, average rating, and the username and title of the responding user.

#### Authentication
This API uses a simple token authentication. Ex:
`curl -H "Authorization: Token abc123" http://localhost:3000/questions`


Please assume that the architecture of this application is not set in stone, and that you have free reign to make architectural changes.



# Solution

### Background
This code challenge involves refactoring an application that is currently running in production and performing sort of fine. The primary objective is to review the existing code, refactor it to improve scalability, facilitate the addition of new features, and enhance maintainability.

### Considerations

As this is a production application, the existing code has not been entirely replaced. Instead, a new API version has been created to allow clients to migrate gradually to the new specification.
Some of the features in th README are not working or don't exists. I have fixed minor bugs but have not implemented new features. This work serves as a foundation for future development.
The new code works to a extent, I didn't check if the requests are returning exactly what is expected. Most of it is only a cleanup and refactor. For this exercise, I believe is more important the show how I like to think and work rather than the actual code details. It could be perfect but that's not doable in 5h :)
Copilot/ChatGPT were used in some parts. This can be considered as cheating but I didn't use it as much as I could and I used no suggestions for the architecture, only to quickly generate some tests. As normal, it wasn't perfect so I had to improve their answers.
Solution
Given the production status of the current application, a new API version (v2) has been created, featuring simplified endpoints, compatibility with OpenAPI, and adherence to modern best practices.

### Key improvements

Ruby upgraded to 3.3 and rails to 7.2
Test coverage increased to 94.41%
openapi compliant api in api/v2 namespace
Minor bug fixes to avoid n+1 calls and sql injections vulnerabilities

### Key decisions

In any refactor is important to have as much test coverage as possible. The first step was to add more tests and use tools to check coverage and code problems
Any normal API renders json data. The original code uses jsonbuilder for it. I opted to use a newer, and faster, serializer jsonapi-rails because I've never worked with it. Using a gem is not mandatory, a simple decorator class with a to_json method could be enough
Ruby and Rails upgrades usually brings improvements in terms of performance and features but like any other migration, it can be hard. In this case was quite easy so I updated it after the extra tests
The old application doesn't follow "modern" best practices and everything lived in the controller. I always try to separate actions as much as possible and create commands/concerns/services,... New controllers still have too much logic but I didn't want to spend too much time on it.
Emails are sent in certain actions and, in the old code, synchronously. I added solid_queue to handle actions that can be processed in background. I chose it, again, because i've never used it and because is the "new kid on the block". Sidekiq is also an option but in this case we need a Redis server.
Sqlite is used as database engine. There are discussions lately about it being able to handle production environments so I didn't touch that part.
Using tokens to authenticate the api calls is not an uncommon practice but is not the best. As I don't control the frontend, I left it that way
As there is no mention about deployments or the production environment, I didn't touch that part either

### Future improvements

Implement JWT or OAuth for more secure authentication, as tokens alone are risky and should ideally be encrypted.
Transition to PostgreSQL for better performance, reliability, and features such as read replicas and full-text search capabilities for tags
Integrate an external service like Elasticsearch for enhanced search functionality.
Dockerize and deploy as container into a cluster for better scalability and management.
