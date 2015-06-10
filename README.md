This repo serves as a case study of a real-world UI problem, demonstrating how one might refactor a bloated controller into reusable layers that are easier to maintain.

## The User Story
> Jill works for *The Widget Factory*, a company in the business of making widgets. Oftentimes, she wants to be able to test how slightly different widgets perform against each other.

> Rather than waste time creating the otherwise-same widget several times over, she would like to be able to quickly generate the different permutations, and be done with it.

## A First Iteration
One of the most common pitfalls seen in Angular apps are bloated controllers, and the templates that go with them. See

* [SpaghettiWidgetBuilderController](src/widget/controller/spaghetti-widget-builder-controller.coffee)
* [spaghetti-widget-builder.jade](src/widget/spaghetti-widget-builder.jade)

What do we do when we want to start creating permutations of *Gadgets*, as well?

## Teasing Out The Layers

#### Services
* [permutationFactory](src/permutation/service/permutation-factory.coffee) - Utility service to generate permutations
* [PermutationBuilderService](src/permutation/service/permutation-builder-service.coffee) - An abstract service that can be extended for different types of permutable resources. Manages the state and logic for a permutation builder UI flow. Contractually bound to the directives below.

#### Directives
* [kcPermutationBuilder](src/permutation/directive/permutation-builder-directive.coffee) - Binds an instance of the service to the UI, exposing its API to child directives.
* [kcPermutableInput](src/permutation/directive/permutable-input-directive.coffee) - Directive that encapsulates the input for a permutable attribute.
* [kcPermutableAttribute](src/permutation/directive/permutable-attribute-directive.coffee) - Displays (and enables user to delete) entered values for a permutable attribute.

## The New, Improved Widget Builder
With the abstracted directives and services, our widget builder becomes much thinner.

* [widgetFactory](src/widget/service/widget-factory.coffee) - Service that builds and validates widgets
* [WidgetBuilderService](src/widget/service/widget-builder-service.coffee) - Extends `PermutationBuilderService` to define widget attributes and how widgets get persisted.
* [WidgetBuilderController](src/widget/controller/widget-builder-controller.coffee) - A much thinner controller.
* [widget-builder.jade](src/widget/widget-builder.jade) - And its accompanying template.
