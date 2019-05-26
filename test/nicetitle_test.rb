require "test_helper"
require "nicetitle/titlecase"

class NicetitleTest < Minitest::Test

  # Attribution for test cases: https://raw.githubusercontent.com/ap/titlecase/master/test.pl
  NT_TEST_CASES = [
    [
      "For step-by-step directions email someone@gmail.com",
      "For Step-by-Step Directions Email someone@gmail.com"],
    [
      "2lmc Spool: 'Gruber on OmniFocus and Vapo(u)rware'",
      "2lmc Spool: 'Gruber on OmniFocus and Vapo(u)rware'"],
    [
      "Have you read “The Lottery”?",
      "Have You Read “The Lottery”?"],
    [
      "your hair[cut] looks (nice)",
      "Your Hair[cut] Looks (Nice)"],
    [
      "People probably won't put http://foo.com/bar/ in titles",
      "People Probably Won't Put http://foo.com/bar/ in Titles"],
    [
      "Scott Moritz and TheStreet.com’s million iPhone la‑la land",
      "Scott Moritz and TheStreet.com’s Million iPhone La‑La Land"],
    [
      "BlackBerry vs. iPhone",
      "BlackBerry vs. iPhone"],
    [
      "Notes and observations regarding Apple’s announcements from ‘The Beat Goes On’ special event",
      "Notes and Observations Regarding Apple’s Announcements From ‘The Beat Goes On’ Special Event"],
    [
      "Read markdown_rules.txt to find out how _underscores around words_ will be interpretted",
      "Read markdown_rules.txt to Find Out How _Underscores Around Words_ Will Be Interpretted"],
    [
      "Q&A with Steve Jobs: 'That's what happens in technology'",
      "Q&A With Steve Jobs: 'That's What Happens in Technology'"],
    [
      "What is AT&T's problem?",
      "What Is AT&T's Problem?"],
    [
      "Apple deal with AT&T falls through",
      "Apple Deal With AT&T Falls Through"],
    [
      "this v that",
      "This v That"],
    [
      "this vs that",
      "This vs That"],
    [
      "this v. that",
      "This v. That"],
    [
      "this vs. that",
      "This vs. That"],
    [
      "The SEC's Apple probe: what you need to know",
      "The SEC's Apple Probe: What You Need to Know"],
    [
      "'by the way, small word at the start but within quotes.'",
      "'By the Way, Small Word at the Start but Within Quotes.'"],
    [
      "Small word at end is nothing to be afraid of",
      "Small Word at End Is Nothing to Be Afraid Of"],
    [
      "Starting sub-phrase with a small word: a trick, perhaps?",
      "Starting Sub-Phrase With a Small Word: A Trick, Perhaps?"],
    [
      "Sub-phrase with a small word in quotes: 'a trick, perhaps?'",
      "Sub-Phrase With a Small Word in Quotes: 'A Trick, Perhaps?'"],
    [
      "Sub-phrase with a small word in quotes: \"a trick, perhaps?\"",
      "Sub-Phrase With a Small Word in Quotes: \"A Trick, Perhaps?\""],
    [
      "\"Nothing to Be Afraid of?\"",
      "\"Nothing to Be Afraid Of?\""],
    [
      "a thing",
      "A Thing"],
    [
      "Dr. Strangelove (or: how I Learned to Stop Worrying and Love the Bomb)",
      "Dr. Strangelove (Or: How I Learned to Stop Worrying and Love the Bomb)"],
    [
      "  this is trimming",
      "This Is Trimming"],
    [
      "this is trimming  ",
      "This Is Trimming"],
    [
      "  this is trimming  ",
      "This Is Trimming"],
    [
      "IF IT’S ALL CAPS, FIX IT",
      "If It’s All Caps, Fix It"],
    [
      "___if emphasized, keep that way___",
      "___If Emphasized, Keep That Way___"],
    [
      "What could/should be done about slashes?",
      "What Could/Should Be Done About Slashes?"],
    [
      "Never touch paths like /var/run before/after /boot",
      "Never Touch Paths Like /var/run Before/After /boot"],
    [
      "There are 100's of buyer's guides",
      "There Are 100's of Buyer's Guides"
    ],
  ].freeze

  def test_titlecase_test_cases
    NT_TEST_CASES.each do |test_case|
      result = Nicetitle::Titlecase.titlecase(test_case[0])
      # titlecase() replaces funny white space by regular space which means
      # we need to do the same replacement here before comparing results.
      assert result == test_case[1].gsub("\u{2011}", " ")
    end
  end

  def test_empty_strings
    assert '' == Nicetitle::Titlecase.titlecase('')
    assert '' == Nicetitle::Titlecase.titlecase(' ')
    assert '' == Nicetitle::Titlecase.titlecase(" \u{2011} ")
    assert '' == Nicetitle::Titlecase.titlecase(" \t \t ")
  end

  def test_small_words
    assert "A a Are Two As" ==
      Nicetitle::Titlecase.titlecase("a a are two as")

    assert "Is Is IS Is a Special Case" ==
      Nicetitle::Titlecase.titlecase("Is is IS Is a special case")

    assert "He Said: A Small Letter After a Word Ending by a Colon Is Capitalized" ==
      Nicetitle::Titlecase.titlecase("He said: a small letter after a word ending by a colon is capitalized")

    assert "The Words a, an, as, and at Should Not Be Capitalized" ==
      Nicetitle::Titlecase.titlecase("The words a, an, as, and at should not be capitalized")

    assert "The Words but and by Should Not Be Capitalized" ==
      Nicetitle::Titlecase.titlecase("The words but and by should not be capitalized")

    assert "The Words en, for, if, in, of, on, or, the, and to Should Not Be Capitalized" ==
      Nicetitle::Titlecase.titlecase("The words en, for, if, in, of, on, or, the, and to should not be capitalized")

    assert "The Words vs, vs., v, and v. Should Not Be Capitalized" ==
      Nicetitle::Titlecase.titlecase("The words vs, vs., v, and v. should not be capitalized")
  end

  def test_all_caps
    assert "Please Stop Shouting!" ==
      Nicetitle::Titlecase.titlecase("PLEASE STOP SHOUTING!")
  end

  def test_words_starting_with_special_characters
    assert "___Foo Bar Woo___" ==
      Nicetitle::Titlecase.titlecase("___foo bar woo___")
    assert "(Foo Bar Woo)" ==
      Nicetitle::Titlecase.titlecase("(foo bar woo)")
    assert "'Foo Bar Woo'" ==
      Nicetitle::Titlecase.titlecase("'foo bar woo'")
    assert "\"Foo Bar Woo\"" ==
      Nicetitle::Titlecase.titlecase("\"foo bar woo\"")
  end

  def test_words_starting_and_interspersed_with_dashes
    assert "-Foo-Bar-Woo" ==
      Nicetitle::Titlecase.titlecase("-foo-bar-woo")
  end

  def test_words_interspersed_with_slashes
    assert "Foo/Bar/Woo" ==
      Nicetitle::Titlecase.titlecase("foo/bar/woo")
  end

  def test_words_starting_with_slashes
    assert "/usr/bin" ==
      Nicetitle::Titlecase.titlecase("/usr/bin")
  end

  def test_words_containing_urls
    assert "The URLs http://example.com and https://example.com Remain Untouched" ==
      Nicetitle::Titlecase.titlecase("The URLs http://example.com and https://example.com remain untouched")
  end

  def test_words_containing_capitals
    assert "Words Such as iPhone, iOS, NBC, and PoC Remain Untouched" ==
      Nicetitle::Titlecase.titlecase("Words such as iPhone, iOS, NBC, and PoC remain untouched")
  end

  def test_words_containing_dots
    assert "Words Such as foo.bar.1001 Remain Untouched" ==
      Nicetitle::Titlecase.titlecase("Words such as foo.bar.1001 remain untouched")
  end

end
