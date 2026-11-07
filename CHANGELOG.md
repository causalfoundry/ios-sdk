# Changelog

Documenting the changes in the SDK subject to each release version.

The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## **[Unreleased]**

- When the SDK is initialized after launch (for example after login), the app-open event is now logged and stored events are synced right away; previously nothing was uploaded until a background task ran or the app was backgrounded and reopened
- Fixed events and catalog items being lost when they were logged while an upload was in flight: a successful upload now removes only the uploaded items instead of clearing the whole store, and store writes are serialized
- Stored events are now also uploaded when the app returns to the foreground (`willEnterForeground`), not only on `didBecomeActive`, which iOS 26 did not always deliver after the keyboard had been dismissed; overlapping uploads are skipped so events are not sent twice

## **[1.0.12]  - 06.11.2026**

- Fixed a crash when the app moved to the background and the SDK was initialized after launch (for example after login): background tasks are no longer submitted unless their handlers were registered at launch
- Added `Kenkai.registerBackgroundTasks()`: call it from `application(_:didFinishLaunchingWithOptions:)` if you call `configure()` later, so background uploads keep working
- Fixed a crash (`Access key not found`) when lifecycle or automatic page events fired before `CFLogBuilder().build()`; those events are now dropped
- Release builds no longer crash on SDK validation errors raised before initialization (the debug-only crash now follows the build type from the start)
- `fetchActions` now always calls back: with no actions before the SDK is initialized, and when the request fails (previously the callback never ran)
- In-app messages and action fetches now work right after a late `configure()` (for example after login) without backgrounding the app first; the SDK treats the app as open when configured in the foreground
- Fixed event uploads when anonymous users are not allowed: events are now sent for the logged-in user (previously nothing was uploaded at all), and the upload path always reports back, so background upload tasks finish and an event logged before login is stored instead of lost
- Background task registration is skipped (instead of crashing) when the task identifiers are missing from `BGTaskSchedulerPermittedIdentifiers`, and background tasks that run before the SDK is initialized finish without doing work
- Actions returned by `fetchActions` can now be read by the app (`payload.type`, `renderMethod`, `content`, `attr`, `error`)
- Added `CFCoreEvent.shared.logActionResponse(action:response:details:)` to report how the user responded to an action the app shows itself
- Catalog items logged before `CFLogBuilder().build()` now stay stored until the SDK is initialized (previously an upload before initialization sent them without an SDK key, the API rejected them, and they were deleted as if uploaded)
- Report responses to actions you render yourself with `CFCoreEvent.shared.logActionResponse(action: item, response: .Shown)`, passing the item from `fetchActions` as is; building an `ActionRepsonseObject` by hand is no longer needed (the type, `CodableValue` and `payload.internalObject` are public for apps that persist actions)
- The "Task ... completed" log line for every SDK request now includes the HTTP status code

## **[1.0.11]  - 01.11.2026**

- Removed the "Enable Background App Refresh" alert that was shown on every app launch when Background App Refresh was off
- Fixed a possible crash when Background App Refresh was turned on while the app was running, by always registering background tasks at launch
- Fixed a crash when `Kenkai.shared.configure()` was called more than once
- Fixed debug builds crashing on network failures (e.g. app backgrounded mid-request); these are still reported as exception events


## **[1.0.10]  - 07.08.2026**

- Added support for custom catalogs using `CoreCatalogType.Other` and `OtherCatalogModel`, with Web-compatible recursive key normalization
- Fixed a crash caused by duplicate item identifiers when displaying InApp Messages


## **[1.0.9]  - 05.08.2026**

- Updated Body text color for InApp Message


## **[1.0.2]  - 05.08.2026**

- Fixed InApp Message theme for light mode only


## **[1.0.1]  - 10.11.2025**

- Include `CFCoreEvent.shared.fetchActions(...)"` for fetching any type of actions with the relevant params
- Update Action callbacks to return all attributes from the action request
- Default include `notification_permission` in user catalog/dimension with default values as `granted` & `denied`


## **[1.0.0]  - 31.10.2025**

- Initial SDK Release                                                 

----
