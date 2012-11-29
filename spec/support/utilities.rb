require 'active_support/inflector'
require 'faker'

def factory(table, default_attrs, change_attrs)
    attrs = default_attrs
    attrs = default_attrs.merge(change_attrs) if change_attrs

    obj = eval("#{table.to_s.camelcase}.new")
    obj.assign_attributes(attrs, :without_protection => true)
    return obj
end
