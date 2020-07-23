Object subclass: #Post
	instanceVariableNames: 'text timeStamp'
	classVariableNames: ''
	package: 'SimpleNet-Model'!

!Post methodsFor: 'accessing' stamp: 'Casco 4/5/2020 11:58'!
text: anObject
	text := anObject! !

!Post methodsFor: 'accessing' stamp: 'Casco 4/5/2020 11:58'!
text
	^ text! !

!Post methodsFor: 'accessing' stamp: 'Casco 4/5/2020 11:59'!
timeStamp
	^ timeStamp! !


!Post methodsFor: 'initialization' stamp: 'Casco 4/5/2020 11:59'!
initialize
	timeStamp := DateAndTime now! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Post class
	instanceVariableNames: ''!

!Post class methodsFor: 'accessing' stamp: 'Casco 4/5/2020 12:01'!
text: aString
	^ self new
		text: aString;
		yourself! !


Object subclass: #SimpleNet
	instanceVariableNames: 'users'
	classVariableNames: ''
	package: 'SimpleNet-Model'!

!SimpleNet methodsFor: 'initialization' stamp: 'Casco 4/5/2020 10:02'!
addUser: aUser
	users add: aUser! !


!SimpleNet methodsFor: 'utility' stamp: 'Casco 4/5/2020 11:43'!
usersMatchingNamePart: aString
	^ users
		select:
			[ :each | each name asLowercase includesSubstring: aString asLowercase ]! !

!SimpleNet methodsFor: 'utility' stamp: 'Casco 4/5/2020 10:11'!
userWithEmail: anEmail protectedBy: aPassword
	^ users
		detect: [ :each | each email = anEmail & (each password = aPassword) ]
		ifNone: [ nil ]! !


!SimpleNet methodsFor: 'accessing' stamp: 'Casco 4/5/2020 10:06'!
users
	^ users! !

!SimpleNet methodsFor: 'accessing' stamp: 'Casco 4/5/2020 10:02'!
initialize
	users := OrderedCollection new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

SimpleNet class
	instanceVariableNames: 'soleInstance'!

!SimpleNet class methodsFor: 'instance creation' stamp: 'Casco 4/5/2020 10:05'!
soleInstance
	^ soleInstance ifNil: [ soleInstance := self new ]! !

!SimpleNet class methodsFor: 'instance creation' stamp: 'Casco 4/5/2020 12:47'!
clearSoleInstance
	soleInstance := nil! !


Object subclass: #User
	instanceVariableNames: 'name email password friends posts'
	classVariableNames: ''
	package: 'SimpleNet-Model'!

!User methodsFor: 'accessing' stamp: 'Casco 4/5/2020 12:06'!
postsInNetwork
	^ (friends flatCollect: [ :each | each posts ]) , posts
		asSortedCollection: [ :a :b | a timeStamp > b timeStamp ]! !

!User methodsFor: 'accessing' stamp: 'Casco 4/4/2020 21:23'!
name: anObject
	name := anObject! !

!User methodsFor: 'accessing' stamp: 'Casco 4/5/2020 09:58'!
friends
	^ friends! !

!User methodsFor: 'accessing' stamp: 'Casco 4/4/2020 21:23'!
name
	^ name! !

!User methodsFor: 'accessing' stamp: 'Casco 4/5/2020 09:58'!
posts
	^ posts! !

!User methodsFor: 'accessing' stamp: 'Casco 4/5/2020 10:00'!
befriend: aUser
	(friends includes: aUser)
		ifTrue: [ ^ self ].
	friends add: aUser.
	aUser befriend: self! !

!User methodsFor: 'accessing' stamp: 'Casco 4/4/2020 21:23'!
password: anObject
	password := anObject! !

!User methodsFor: 'accessing' stamp: 'Casco 4/5/2020 10:06'!
email
	^ email! !

!User methodsFor: 'accessing' stamp: 'Casco 4/5/2020 12:10'!
post: aPost
	posts add: aPost ! !

!User methodsFor: 'accessing' stamp: 'Casco 4/5/2020 10:06'!
email: anObject
	email := anObject! !

!User methodsFor: 'accessing' stamp: 'Casco 4/4/2020 21:23'!
password
	^ password! !


!User methodsFor: 'initialization' stamp: 'Casco 4/5/2020 10:01'!
initialize
	friends := OrderedCollection new.
	posts := OrderedCollection new! !

!User methodsFor: 'initialization' stamp: 'Casco 4/5/2020 11:46'!
canBefriend: aUser
	aUser == self
		ifTrue: [ ^ false ].
	(friends includes: aUser)
		ifTrue: [ ^ false ].
	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

User class
	instanceVariableNames: ''!

!User class methodsFor: 'instance creation' stamp: 'Casco 4/5/2020 10:47'!
name: aName email: anEmail password: aClearTextPassword
	^ self new
		name: aName;
		email: anEmail;
		password: aClearTextPassword;
		yourself! !
WAComponent subclass: #AccessGrantingComponent
	instanceVariableNames: 'email password'
	classVariableNames: ''
	package: 'SimpleNet-Seaside'!

!AccessGrantingComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 10:34'!
renderContentOn: aCanvas
	aCanvas
		form: [ self renderInputElementsOn: aCanvas.
			self renderButtonsOn: aCanvas ]! !

!AccessGrantingComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 10:41'!
renderButtonsOn: aCanvas
	self subclassResponsibility! !

!AccessGrantingComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 10:43'!
renderInputElementsOn: aCanvas
	aCanvas label: 'Email'.
	aCanvas paragraph: [ aCanvas textInput on: #email of: self ].
	aCanvas label: 'Password'.
	aCanvas paragraph: [ aCanvas passwordInput on: #password of: self ]! !


!AccessGrantingComponent methodsFor: 'accessing' stamp: 'Casco 4/5/2020 10:07'!
email: anObject
	email := anObject! !

!AccessGrantingComponent methodsFor: 'accessing' stamp: 'Casco 4/4/2020 21:28'!
password
	^ password! !

!AccessGrantingComponent methodsFor: 'accessing' stamp: 'Casco 4/4/2020 21:28'!
password: anObject
	password := anObject! !

!AccessGrantingComponent methodsFor: 'accessing' stamp: 'Casco 4/5/2020 10:07'!
email
	^ email! !


!AccessGrantingComponent methodsFor: 'private' stamp: 'Casco 4/5/2020 11:21'!
proceedWith: aUser
	self session user: aUser.
	self call: HomeComponent new! !



!AccessGrantingComponent methodsFor: 'model' stamp: 'Casco 4/5/2020 10:22'!
model
	^ SimpleNet soleInstance! !


WAComponent subclass: #FriendsFinderComponent
	instanceVariableNames: 'searchText'
	classVariableNames: ''
	package: 'SimpleNet-Seaside'!

!FriendsFinderComponent methodsFor: 'accessing' stamp: 'Casco 4/5/2020 11:37'!
searchText
	^ searchText! !

!FriendsFinderComponent methodsFor: 'accessing' stamp: 'Casco 4/5/2020 11:37'!
searchText: anObject
	searchText := anObject! !


!FriendsFinderComponent methodsFor: 'initialization' stamp: 'Casco 4/5/2020 11:38'!
initialize
	super initialize.
	searchText := ''! !


!FriendsFinderComponent methodsFor: 'callbacks' stamp: 'Casco 4/5/2020 11:48'!
befriend: anUser
	self session user befriend: anUser! !


!FriendsFinderComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 11:39'!
renderSearchFormOn: aCanvas
	aCanvas
		form: [ aCanvas textInput on: #searchText of: self.
			aCanvas space.
			aCanvas submitButton with: 'Search' ]! !

!FriendsFinderComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 11:42'!
renderSearchResultsOn: aCanvas
	| users |
	searchText ifEmpty: [ ^ self ]. 
	users := SimpleNet soleInstance usersMatchingNamePart: searchText.
	users
		ifEmpty: [ aCanvas
				paragraph: 'Sorry... no matches... no friends for you this time.' ]
		ifNotEmpty:
			[ self renderUsers: users on: aCanvas ]! !

!FriendsFinderComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 11:45'!
renderUsers: users on: aCanvas
	^ aCanvas
		unorderedList: [ users
				do: [ :each | 
					(self session user canBefriend: each)
						ifTrue: [ aCanvas
								listItem: [ aCanvas
										text: each name;
										space.
									aCanvas anchor
										callback: [ self befriend: each ];
										with: [ aCanvas button: 'Befriend' ] ] ] ] ]! !

!FriendsFinderComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 11:49'!
renderContentOn: aCanvas
	self renderSearchFormOn: aCanvas.
	self renderSearchResultsOn: aCanvas.
	aCanvas horizontalRule.
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button: 'Finish' ]! !


WAComponent subclass: #HomeComponent
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'SimpleNet-Seaside'!

!HomeComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 12:08'!
renderPostsOn: aCanvas
	aCanvas heading
		level: 2;
		with: 'Posts'.
	aCanvas
		unorderedList: [ self session user postsInNetwork
				do: [ :each | aCanvas listItem: each text ] ].
	aCanvas anchor
		callback: [ self createNewPost ];
		with: [ aCanvas button: 'New post' ]! !

!HomeComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 11:05'!
renderLogoutButtonOn: aCanvas
	aCanvas
		paragraph: [ aCanvas anchor
				callback: [ self answer ];
				with: [ aCanvas button with: 'Logout' ] ]! !

!HomeComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 11:21'!
renderFriendsOn: aCanvas
	aCanvas heading
		level: 2;
		with: 'Friends'.
	aCanvas
		unorderedList: [ self session user friends do: [ :each | aCanvas listItem: each name ] ].
	aCanvas anchor
		callback: [ self findFriend ];
		with: [ aCanvas button: 'Find friends' ]! !

!HomeComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 11:22'!
renderContentOn: aCanvas
	aCanvas heading: 'Welcome ' , self session user name.
	self renderPostsOn: aCanvas.
	aCanvas horizontalRule.
	self renderFriendsOn: aCanvas.
	aCanvas horizontalRule.
	self renderLogoutButtonOn: aCanvas! !


!HomeComponent methodsFor: 'callbacks' stamp: 'Casco 4/5/2020 11:17'!
createNewPost
	self call: NewPostComponent new! !

!HomeComponent methodsFor: 'callbacks' stamp: 'Casco 4/5/2020 11:37'!
findFriend
	self call: FriendsFinderComponent new! !


AccessGrantingComponent subclass: #LoginComponent
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'SimpleNet-Seaside'!
!LoginComponent commentStamp: 'Casco 4/5/2020 11:20' prior: 0!
| application |
application := WAAdmin register: LoginComponent asApplicationAt: 'simple-net'.
application sessionClass: SessionWithUser.
!


!LoginComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 10:52'!
renderSignUpButtonOn: aCanvas
	aCanvas submitButton
		callback: [ self registerNewUser ];
		with: 'Sign Up, it''s free'! !

!LoginComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 10:53'!
renderButtonsOn: aCanvas
	self renderSignInButtonOn: aCanvas.
	aCanvas horizontalRule.
	aCanvas paragraph: 'Don''t have an account?'.
	self renderSignUpButtonOn: aCanvas! !

!LoginComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 10:51'!
renderSignInButtonOn: aCanvas
	aCanvas submitButton
		callback: [ self login ];
		with: 'Sign In'! !


!LoginComponent methodsFor: 'callbacks' stamp: 'Casco 4/5/2020 10:42'!
registerNewUser
	self call: RegisterComponent new! !

!LoginComponent methodsFor: 'callbacks' stamp: 'Casco 4/5/2020 10:40'!
login
	(self model userWithEmail: email protectedBy: password)
		ifNotNil: [ :it | self proceedWith: it ].
	email := nil.
	password := nil! !


WAComponent subclass: #NewPostComponent
	instanceVariableNames: 'postText'
	classVariableNames: ''
	package: 'SimpleNet-Seaside'!

!NewPostComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 11:19'!
renderContentOn: aCanvas
	aCanvas
		form: [ (aCanvas textArea on: #postText of: self)
				columns: 80;
				rows: 5.
			aCanvas break.
			aCanvas submitButton
				callback: [ self post ];
				with: 'Post' ]! !


!NewPostComponent methodsFor: 'callbacks' stamp: 'Casco 4/5/2020 12:11'!
post
	postText ifEmpty: [ ^ self ].
	self session user
		post: (Post text: postText , ' (' , self session user name , ')').
	self answer! !


!NewPostComponent methodsFor: 'accessing' stamp: 'Casco 4/5/2020 11:14'!
postText
	^ postText! !

!NewPostComponent methodsFor: 'accessing' stamp: 'Casco 4/5/2020 11:14'!
postText: anObject
	postText := anObject! !


AccessGrantingComponent subclass: #RegisterComponent
	instanceVariableNames: 'name'
	classVariableNames: ''
	package: 'SimpleNet-Seaside'!

!RegisterComponent methodsFor: 'accessing' stamp: 'Casco 4/5/2020 10:37'!
name
	^ name! !

!RegisterComponent methodsFor: 'accessing' stamp: 'Casco 4/5/2020 10:37'!
name: anObject
	name := anObject! !


!RegisterComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 10:51'!
renderButtonsOn: aCanvas 
	self renderSignUpButtonOn: aCanvas! !

!RegisterComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 10:44'!
renderInputElementsOn: aCanvas
	aCanvas label: 'Name'.
	aCanvas paragraph: [ aCanvas textInput on: #name of: self ].
	super renderInputElementsOn: aCanvas! !

!RegisterComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 10:48'!
registerAndLogin
	| theUser |
	theUser := User name: name email: email password: password.
	self model addUser: theUser.
	self proceedWith: theUser! !

!RegisterComponent methodsFor: 'rendering' stamp: 'Casco 4/5/2020 10:51'!
renderSignUpButtonOn: aCanvas
	aCanvas submitButton
		callback: [ self registerAndLogin ];
		with: 'Register'! !


WASession subclass: #SessionWithUser
	instanceVariableNames: 'user'
	classVariableNames: ''
	package: 'SimpleNet-Seaside'!

!SessionWithUser methodsFor: 'accessing' stamp: 'Casco 4/5/2020 11:23'!
user: anObject
	user := anObject! !

!SessionWithUser methodsFor: 'accessing' stamp: 'Casco 4/5/2020 11:23'!
user
	^ user! !
