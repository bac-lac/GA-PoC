# Introduction
This script is used to run a load test on a GoAnywhere application.
The test flow is composed of 6 HTTP request which are also downloading referenced resources on each pages:
1.  get GA login page.
    http request to the GA login url.
2.  send credentials.
    Login to the application.
3.  get GA dashboard page.
    http request to the GA dashboard url.
4.  get GA browseproject page
    http request to the GA project url.
5.  post GA specified project page
    http resquest to execute a specified flow.
6.  user logout.
    loging out the user.

# Prerequisites
1.  GoAnywhere application running in a publicly accessible URL.
2.  An active user to run the flow.
3.  A test flow with your requirements in the application.

# Getting Started
The jmeter test can be executed locally or through any jmeter capable process.

## Setting the variables
1.  Configure the following variables in jmeter:
- **ga_host** *: The GA host url.
- **value_hinput** *: The value_hinput value of GA of the account used to test your flow.
- **name** *: The username of the account used to test your flow.
- **value** *: The password of the account used to test your flow.
- **threads** *: The amount of threads you would like to use.
- **rampup** *: The rampup time to get all the threads running at the same time.
- **loop** *: The amount of loop for each threads.
- **HTTP Request - post GA specified project page** *: Fill in the correct value for the flow you would like to execute.

## Gathering the results
The following results can be obtained:
1.  jmeter.csv
2.  graphical report using jviewer by using the following command:
    1.  jmeter -g /path/to/yourreport_t_r_l.csv -o /path/to/outputfolder/
    The above will give you a html base graphic report.