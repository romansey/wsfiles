# AGENTS.md

## Code style

* Make the code as easy to maintain and understand as possible.
* Avoid big inline constructs except for typical chained calls (e.g., fluent APIs).
* Extract complex logic into well-named functions.

## Tests

* When writing tests, try to structure the test body into three parts: setup, execution, and assertions.
* Write separate tests for separate aspects/cases.
* Try to avoid mocking
    * Structure the code in a way that most components can be fully unit tested without mocks
    * Use integration tests for the remaining test cases
