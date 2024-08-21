# Kyruus Medical Group Interview Project

Thanks for being interested in coming to work here at Kyruus. Our team values building, reviewing, and pairing on well-crafted applications.  This repo was built to test how you build applications and how you would fit in working with the team at Kyruus.  It's a simplified version of our Check-in application, and will give you some insight into our product development process.  If you'd like to learn more about our Check-in product please visit our [website](https://epionhealth.com/patient-engagement-software/patient-check-in-software/).

## Setup

Please go ahead and clone this repo and run `bin/setup` to get everything up and running. Before you start, you should have:

* Ruby 3.1.2

We use the following software versions (if you have previous releases and they work well there's no need to update):

* Postgres 14.5
* Redis 7
* Node 18.12.1
* Yarn 1.22.19

The setup process will install dependencies, and automatically configure the database to have a sample patient to work with for your interview.  If you run into any issues with setup, please reach out to your interview team to ask for assistance.

## First passing spec

Now that your repo is setup, we can start the fun stuff!  First create a new branch off of `main` to develop on. Next go ahead and run `bundle exec rspec`. You should see one failing spec. As a warm up, add _just enough_ code to make this test pass. Then do a git commit.

## Part 1: Adding a Patient Questionnaire

One of the most common pieces of check-in paperwork is a patient questionnaire to help assess if a patient is suffering from a specific ailment, which we'll call a "screener." We've implemented a number of screeners in our application, but for the this exercise, you're going to add the first one, the PHQ for depression screening.

You can see a PDF that shows the questions in the form here: https://www.uspreventiveservicestaskforce.org/Home/GetFileByID/218

Part 1 of your assignment is to:

- [ ] Create a form with the first 2 scored questions the patient can complete
- [ ] Calculate the resulting score based on the rules (see below)
- [ ] Store the results for this check-in
- [ ] Show a message to the user about whether they need additional screening (see below)

There's lots of other things we can do, but this is the simplest starting point.

*When* I am completing the checkin
*I want to* calculate and store my PHQ2 score
*so that* a further depression diagnosis can be performed per the protocol.

### Additional information about the task

The form looks like this:

```
Over the past 2 weeks, how often have you been bothered by any of the following problems?

1. Little interest or pleasure in doing things?

* Not at all
* Several days
* More than half the days
* Nearly every day

2. Feeling down, depressed or hopeless?

* Not at all
* Several days
* More than half the days
* Nearly every day
```

Those two questions are scored as follows:

0 * Not at all
1 * Several days
2 * More than half the days
3 * Nearly every day

A question would be considered to have a `high` score if the patient chose `2 * More than half the days` or `3 * Nearly every day`. If either question 1 or question 2 is scored as `high`, or if both questions are scored as `high`, the user should be shown a message that additional screening should be completed. Otherwise the user should be shown a message that additional screening is not needed.

### Git commit and tests

Do as many git commits as you feel are appropriate. If you are familiar with writing rspec tests, you can also add as many tests as you feel are appropriate.

## Part 2: Adding a personalized greeting

As part of the check-in process, we are frequently required to integrate with health system APIs. One of the most common types of information we interact with are fields related to registration and demographics, e.g. name, location, contact information. In our live application, patients are able to both view and update a comprehensive set of personal information. For this exercise, we will start with a simple greeting that pulls the patient's name from a third party API.

Part 2 of your assignment is to:

- [ ] Retrieve the patient associated with the current check-in using the REST API described below
- [ ] Add a personalized greeting including the patient's first and last names that's displayed prior to beginning the questionnaire from part 1.

*When* I am starting a checkin
*I want to* see a personalized greeting
*so that* I feel confident that the application is trustworthy.

### Additional information about the task

We will be integrating with a dummy API that returns fake user information. The API can be reached by making a `GET` request to `https://dummyjson.com/users/1`. No authorization is required for the request. A simple example using `curl` can be found below.

```shell
curl 'https://dummyjson.com/users/1'

{
    "id": 1,
    "firstName": "Terry",
    "lastName": "Medhurst",
    "maidenName": "Smitham",
    "age": 50,
    "gender": "male",
    "email": "atuny0@sohu.com",
    "phone": "+63 791 675 8914",
    "username": "atuny0",
    "password": "9uQFF1Lh",
    "birthDate": "2000-12-25",
    ...
}
```

You can assume that the hardcoded `patient_id` stored on the `CheckIn` model corresponds to the user id to use in the request to the dummy API.

### Git commit and tests

As with part 1, feel free to add as many commits and tests as you feel are appropriate.

## Submitting your work

When you are ready for us to review your work, please create a pull request to the `main` branch containing your commits from part 1 and part 2.
