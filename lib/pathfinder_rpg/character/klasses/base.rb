module PathfinderRpg
  class Character
    module Klass
      class Base
        attr_accessor :level
        attr_accessor :favored

        def initialize(character, level = 1, favored = false)
          @character = character
          @level = level
          @favored = favored
        end

        def label
          self.class.name.demodulize.downcase
        end

        def available_alignments
          configuration['alignments']
        end

        def hit_die
          configuration['hit_die']
        end

        def skills_per_level
          configuration['skill_ranks_per_level'] + @character.intelligence_modifier
        end

        def base_attack_bonus(attack_number = 1)
          raise ArgumentError.new('Not a valid attack number') unless attack_number > 0
          level_configuration_for('base_attack_bonus').at(attack_number - 1) || 0
        end

        def available_attacks
          level_configuration_for('base_attack_bonus').size
        end

        def fortitude_save_base
          level_configuration_for('fortitude_save')
        end

        def reflex_save_base
          level_configuration_for('reflex_save')
        end

        def will_save_base
          level_configuration_for('will_save')
        end

        private

        def level_configuration_for(key)
          configuration['levels'][level][key]
        end
      end
    end
  end
end
