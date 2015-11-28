require "license/compatibility/version"

module License
  module Compatibility
    PUBLIC_DOMAIN = ['PDDL-1.0', 'SAX-PD', 'Unlicense', 'CC0-1.0']
    PERMISSIVE = ['MIT', 'BSD-3-Clause', 'WTFPL', 'BSD-2-Clause', 'ISC',
      'Apache-2.0', 'AFL-1.1', 'AFL-1.2', 'AFL-2.0', 'AFL-2.1', 'AFL-3.0',
      'Artistic-2.0', 'Artistic-2.0', 'EPL-1.0', 'MPL-2.0', 'BSD-3-Clause-Clear',
      'DSDP', 'ECL-2.0', 'BSD-3-Clause-Attribution']
    WEAK_COPYLEFT = ['LGPL-3.0', 'LGPL-2.0', 'LGPL-2.0+', 'LGPL-2.1', 'LGPL-2.1+',
      'LGPL-3.0', 'LGPL-3.0+']
    COPYLEFT = ['GPL-3.0', 'GPL-2.0', 'GPL-2.0+', 'GPL-3.0+']
    STRONG_COPYLEFT = ['AGPL-1.0', 'AGPL-3.0']

    def self.forward_compatiblity(source_license, derivative_license)
      souce_type = license_type(source_license)
      derivative_type = license_type(derivative_license)
      case souce_type
      when :public_domain
        return true
      when :permissive, :weak_copyleft
        [:permissive, :weak_copyleft, :copyleft, :strong_copyleft].include? derivative_type
      when :copyleft
        [:copyleft, :strong_copyleft].include? derivative_type
      when :strong_copyleft
        [:strong_copyleft].include? derivative_type
      else
        raise 'Unknown license compatiblity'
      end
    end

    def self.license_type(license)
      # TODO convert license into standard SPDX format
      if PUBLIC_DOMAIN.include?(license)
        :public_domain
      elsif PERMISSIVE.include?(license)
        :permissive
      elsif WEAK_COPYLEFT.include?(license)
        :weak_copyleft
      elsif COPYLEFT.include?(license)
        :copyleft
      elsif STRONG_COPYLEFT.include?(license)
        :strong_copyleft
      else
        raise 'Unknown license type'
      end
    end
  end
end
