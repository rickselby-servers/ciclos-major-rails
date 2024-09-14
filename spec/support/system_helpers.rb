# frozen_string_literal: true

# Helpers for system spec tests
module SystemHelpers
  # This is only needed for js tests - where the cropper interface is loaded
  # For rack_test driven tests, the file field will be available for completion
  def attach_photo(field = "Photo", file: "400x400")
    click_on "Change Image"
    attach_file field, file_fixture("#{file}.jpg")
    sleep 0.5 # yuck! but required...
    click_on "Save"
  end

  # This is only needed for js tests - where tinymce is loaded.
  # For rack_test driven tests, the textarea will be available for completion
  def fill_in_tinymce(iframe_id, text)
    within_frame(iframe_id) { page.find_by_id("tinymce").set(text) }
  end
end
