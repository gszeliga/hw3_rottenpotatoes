# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    
    #puts "inserting..." + movie.to_s

    Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert page.body.index(e1) < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb

  rating_list.split(",").each do |rating|

    field_id = "ratings[" + rating.strip + "]"

    if not uncheck.nil?
      #puts "unchecking..." + field_id
      uncheck(field_id)
    else
      #puts "checking..." + field_id
      check(field_id)
    end

  end

end

Then /I should see (none|all) of the movies/ do |option|

  if option == 'none'
    #puts 'oh---none#' + all("table#movies tr").count.to_s
    assert_equal 0,all("table#movies tr").count-1
  else
    #puts 'oh---all#' + all("table#movies tr").count.to_s
    assert_equal Movie.count,all("table#movies tr").count-1
  end

end
