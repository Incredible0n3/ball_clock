# encoding: utf-8
###
# @author Dan Oberg <dan@cs1.com>
# @class String
###
class String
  ###
  # @method titleize
  ###
  def titleize
    self.split(' ').collect(&:capitalize).join(' ')
  end
end
