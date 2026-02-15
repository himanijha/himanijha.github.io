# Local-only shim for Ruby 3.2+ / 4.x.
#
# Ruby removed the "taint" mechanism in 3.2, deleting Object#untaint, #taint,
# and #tainted?. The old Liquid (4.0.3) pinned by the github-pages gem still
# calls String#untaint, which crashes `jekyll serve` on modern Ruby with:
#   undefined method 'untaint' for an instance of String
#
# Re-add them as harmless no-ops so local builds work. Plugins in _plugins/ are
# ignored by GitHub Pages' built-in build (it runs in safe mode), so this has no
# effect on the deployed site.
unless Object.method_defined?(:untaint)
  class Object
    def untaint
      self
    end

    def taint
      self
    end

    def tainted?
      false
    end
  end
end
