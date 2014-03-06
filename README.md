What is it?
=================

The central idea of Specification is to separate the statement of how to match a candidate, from the candidate object that it is matched against.
The specification object has a clear and limited responsibility, which can be separated and decoupled from the domain object that uses it.

http://martinfowler.com/apsupp/spec.pdf


How does it look?
==================

Specification exposes only ```is_satisfied_by?``` method.

```ruby
class WithNameSpecification
  def initialize(name); @name = name; end

  def is_satisfied_by?(subject)
    subject.name == @name
  end
end
```

It returns ```true``` or ```false```.

What does it mean?
===================

Specification is matching criteria or validations for selecting proper objects.
That's what we achieve using AR model scopes in Rails (making it fat by the way).
Using specifications we can decouple and reuse them across models.

Examples
===================

## Find Rob with specification

```ruby
spec = WithNameSpecificationn.new('Robert')
people = Person.all

robt = people.find {|person| spec.is_satisfied_by?(person)}
```

Slow, possibly not usable at all (fetches all records from db)
Lots of code


Rails can do better

```ruby
class Person < ActiveRecord::Base
  scope :with_name, lambda {|name| where(:name => name)}
end

Person.with_name('Rob').first
```

## Make it work with AR

```ruby
class WithNameSpecification
  def initialize(name); @name = name; end

  def is_satisfied_by?(subject)
    subject.where(:name => @name)
  end
end
```

Now subject is AR::Relation, it always satisfies the specification.

```ruby
spec = WithNameSpecificationn.new('Rob')
rob = spec.is_satisfied_by?(Person).first
```

still more code than with AR scope...


```ruby
class Cat < ActiveRecord::Base
 scope :with_name, lambda {|name| where(:name => name)}
end

class Dog < ActiveRecord::Base
 scope :with_name, lambda {|name| where(:name => name)}
end

class Duck < ActiveRecord::Base
 scope :with_name, lambda {|name| where(:name => name)}
end

class Cow < ActiveRecord::Base
 scope :with_name, lambda {|name| where(:name => name)}
end

class PinkInvisibleUnicorn < ActiveRecord::Base
 scope :with_name, lambda {|name| where(:name => name)}
end
```

More code no more.

## Maintanance

Client wants the name to be humanized.

```ruby
class Dog < ActiveRecord::Base
 scope :with_name, lambda {|name| where(:name => name.humanize)}
end
```

Need to repeat in each model.

```ruby
class WithNameSpecification
  def initialize(name); @name = name; end

  def is_satisfied_by?(subject)
    subject.where(:name => @name.humanize)
  end
end
```

DRY with spec.
SRP with spec.

```ruby
scope :complex_business_rule, lambda {|param1, param2|
 #complex logic
 #many lines
 #not really readable }
```

Complex business rules make model fat and unmaintainable.
This should be extracted to different object.

```ruby
class ComplexBusinessSpecification
  def initialize(param); @param = param; end

  def is_satisfied_by?(subject)
    subject.where(complex_query_hash)
  end
 
  private

  def complex_query_hash
    #complex code
  end
```

Hidden implementation.
Clean code.


##Some other examples

*find posts (or any other content) without comments
```ruby
class WithoutComments
  def is_satisfied_by?(subject)
    foreign_key = subject.
            reflect_on_association(:comments).foreign_key

    subject.where("not exists 
        (select 1 from comments where
        #{subject.table_name}.#{subject.primary_key} =
        comments.#{foreign_key})")
 end
end
```


Much SQL wow.
Complex logic outside of model, reusable, easy to test and refactor.


*find Posts (or anything else) having comments.
```ruby
class WithComments
  def is_satisfied_by?(subject)
    subject.joins(:comments)
  end
end
```

(the specifications are not limited to "where", they work on ActiveRelation object)


Complex Specifications
======================

Specifications can be combined with each other using generic ```And``` specification
```ruby
class And
  def initialize(specifications)
    @specifications = specifications
  end

  def is_satisfied_by?(subject)
    @specifications.each do |spec|
      subject = spec.is_satisfied_by? subject
    end
    subject
  end
end
```

Find possibly spammy posts:

```ruby
class PossiblySpam
  def initialize
    @specs = [WithoutComments.new, WithoutBody.new]
  end
  
  def is_satisfied_by?(subject)
    And.new(@specs).is_satisfied_by?(subject)
  end
end
```

Can combine complex specifications like any others:

```ruby
class ItHasToBeSpam
 def initialize
    @specs = [PossiblySpam.new, WithoutTitle.new]
 end
 
 def is_satisfied_by?(subject)
   And.new(@specs).is_satisfied_by?(subject)
 end
end
```

##Conclusion

Doing specifications with SQL/ActiveRecord is possible, but painful. I think it's better to use simple scopes where possible. When scope becomes too complicated going with Specification pattern **may** be an option.

It's much more fun to play with PORO.

It's good to know about it, although you will probably never need it.

/sand :panda_face:
