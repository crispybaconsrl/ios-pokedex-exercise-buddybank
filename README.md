# Pokemon

This project use [PokeAPI](https://pokeapi.co) to retrieve pokemon dek and display it on a collection view.

To implement this project I've used MVVM+Coordinator path as requested, without using any Xcode UI facility (xib, storyboards).


### Basic tasks

- ✅ Use Swift 5+
- ✅ No use of SwiftUI.
- ✅ Use IOS 13 SDK as Target.
- ✅ The UI must be created without the use of Xib or Storyboard:  
	**all the UI components have been programmatically created using [PinLayout](https://github.com/layoutBox/PinLayout) library**
- ✅ Architecture pattern MVVM+C with separation of responsibilities.
- ✅ Loading of the list with automatic pagination on scroll:  
	**once reached collection view bottom, `viewModel.loadMore()` is triggered**
- ✅ Use of SPM.
- ✅ Use Gitflow and submit the code by publishing it to a public repository:  
	**initially I created some feature branches in order to define main task (data model, ui..). Onc the task was finished, I created a pull request which I personally accepted**
- ✅ Create a README.md in which you explain the reason for your implementation choices.

### Bonus tasks

- ✅ Using PinLayout to build interfaces (https://github.com/layoutBox/PinLayout)
- ✅ Make maximum use of one external library (excluding PinLayout library)
- ❌ Make the app work even offline:  
	**Currently app doesn't work on offline mode, but I created `NetworkHelper` class that provides all the utilities to complete this task quickly**
- ❌ Add some accessibility features
- ❌ Write Unit and UI Tests:  
	**Unfortunately I didn't have time to implement the tests. again, they can be implemented quite quickly and correctly thanks to dependency injection**
	
	
### Plus tasks

- ✅ Theme manager:  
	I implemented a basic theme manager which help programmer to set app colors and sizes. Is intended to be a demonstration, it could be definitely improved managing fonts/font sizes too.
- ❌ Translations:  
	**To develop a perfect app I should manage language translations, creating Localizable.strings and filling with related key/value**
- ❌ Search on pokemons:  
	**I add a search component using UICollectionReusableView for UICollectionView.elementKindSectionHeader. The flow is quite completed, there is a bug on which I have no time to investigate (search bar resign first responder once I trigger reloadData(). I could have tried using 2 sections, first one for the searchBar, second one for pokemon items and reload the second one section only**