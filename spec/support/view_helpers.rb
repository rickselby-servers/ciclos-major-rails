shared_context "with view rendering" do
  subject(:page) { Capybara.string render(locals:) }

  let(:locals) { {} }
end
