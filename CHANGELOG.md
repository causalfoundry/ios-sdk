# Changelog

Documenting the changes in the SDK subject to each release version.

The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

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
