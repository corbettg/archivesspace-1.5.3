require_relative '../../common/mixed_content_parser'

Dir.glob(File.join(File.dirname(__FILE__), '../', '../', 'common', 'lib', "*.jar")).each do |file|
  require file
end


describe 'MixedContentParser' do

  it "can convert paragraph breaks to paragraph tags", :skip_db_open do
    text = "foo\n\nbar"

    converted = MixedContentParser.parse(text, "http://example.com", {:wrap_blocks => true})

    converted.gsub(/\s/, "").should eq("<p>foo</p><p>bar</p>")
  end


  it "won't pretty print output by default", :skip_db_open do
    text = "What the & 'heck' <emph>ok</emph>?"

    converted = MixedContentParser.parse(text, "http://example.com", {:wrap_blocks => false})

    converted.should eq("What the &amp; 'heck' <span class=\"emph render-none\">ok</span>?");
  end

end
