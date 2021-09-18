# rmvx-ebjb-unit-testing

## Table of contents

- [Quick start](#quick-start)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Creators](#creators)
- [Credits](#credits)

## Quick start

- Run this command to combine external scripts source into one file. `ruby build-ext.rb`
- Run this command to combine core scripts source into one file. `ruby build.rb`
- Copy the resulting files into your RPG Maker VX project 
  > Watch out ! The external scripts needs to be before the core scripts.

OR

- There is an already pre-compiled demo with the classic sample project.

## Documentation

How to find bugs when developing scripts ? You can only be sure this is "bug free" with proper testing. Sadly, this is a boring job to do. So, after doing the same thing over and over again, I decided to create some utility classes (with the help of a console output) to ease the unit testing work by allowing them to be a little more automated.

I took the concept from N-Unit, so for the ones that already used it, you will understand quickly. Unit testing is, simply put, to isolate each part of the program and show that these individual parts are correct. Also, each test must be ran independently of the others, so you will need for example to setup and to cleanup after each test.

I made two utility classes, `Test_Class` and `TestUI_Class`. The first one allows you to do basic unit testing, the latter allows you to do UI unit testing.

It adds more work during development, but you save a lot of time and effort later because when they are done, you only need to run them and you will be able to know if everything is still working perfectly instead of always remembering what tests you did and in which order.

### Instructions for usage

#### Unit Test

Create a new class that inherits from `Test_Class` :

```ruby
class Test_Template < Test_Class
  
  def testFixtureSetup()
    # setup your objects for the tests (if needed)
  end
  
  def testFixtureTearDown()
    # destroy your objects when the tests are finished (if needed)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Tests
  #//////////////////////////////////////////////////////////////////////////

  def test_1
    return true
  end
  
  def test_2
    return false
  end
  
  def test_3
     1/0
    return true
  end
  
end
```

To call it, you only need to instantiate this class :

```ruby
Test_Template.new()
```

You can for example create an event and call the above line of code.

#### Unit UI Test

Create a new class that inherits from `TestUI_Class` :

```ruby
class TestUI_Template < TestUI_Class
  
  def testFixtureSetup()
    # setup your objects for the tests (if needed)
  end
  
  def testFixtureTearDown()
    # destroy your objects when the tests are finished (if needed)
  end

  def update()
    # update your UI objects after the tests have started
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Tests
  #//////////////////////////////////////////////////////////////////////////
  
  def test_1
    return true
  end
  
  def test_2
    return false
  end
  
  def test_3
    1/0
    return true
  end
  
end
```

To call it, you only need to instantiate this class.

```ruby
TestUI_Template.new()
```

You can for example create an event and call the above line of code.

## Contributing

Still in development...

## Creators

- <https://github.com/chaoshades>

## Credits 

- ForeverZer0 : Console Output
