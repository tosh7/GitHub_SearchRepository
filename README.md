# GitHub_SearchRepository
![](https://img.shields.io/badge/Xcode-15.3%2B-blue.svg)
![](https://img.shields.io/badge/iOS-17.0%2B-blue.svg)
![](https://img.shields.io/badge/Swift-5.9%2B-orange.svg)  

## About GitHubRepository
You can search repositories via [GitHub REST API](https://docs.github.com/en/rest?apiVersion=2022-11-28) and star a repository in this app.

## Dependencies
- UIKit
- Combine

## Architecture
- MVVM

## Setup
1. Clone this repository
2. Run below on your command line
```
$cd <your project repository path>
$mkdir GitHub_SearchRepository/Secrets
$touch APIKey.swift
```
3. Add GitHub API Token to APIKey.swift file.
```
import Foundation

enum APIKey {
    static let token: String = "<Your API Token>"
}
```
The API token needs to starring READ/WRITE access.

## License
See the [LICENCE](https://github.com/tosh7/GitHub_SearchRepository/edit/main/LICENSE).
